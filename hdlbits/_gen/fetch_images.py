#!/usr/bin/env python3
"""Download HDLBits figures and WaveDrom waveforms, then embed them in problem markdown."""
from __future__ import annotations

import json
import os
import re
import ssl
import subprocess
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

from emit import ROOT, figures_markdown, insert_figures

API = "https://hdlbits.01xz.net/mw/api.php"
FILEPATH = "https://hdlbits.01xz.net/wiki/Special:FilePath/"
UA = "verilog-know-hows-tutorial/1.0 (educational mirror of HDLBits figures)"
CTX = ssl._create_unverified_context()
SKIP_SUBSTR = (
    "logo270",
    "poweredby_mediawiki",
    "favicon",
    "wiki.png",
    "hdlbits-stat",
)
WAVEDROM_RE = re.compile(r"<wavedrom(?:\s[^>]*)?>\s*(.*?)\s*</wavedrom>", re.I | re.S)
URL_RE = re.compile(r"https://hdlbits\.01xz\.net/wiki/([^\s)\]]+)")
IMG_SRC_RE = re.compile(r'<img[^>]+src=["\']([^"\']+)', re.I)
MW_IMAGE_RE = re.compile(r"/mw/images/[0-9a-f]/[0-9a-f]{2}/([^/?#'\"]+)", re.I)
THUMB_RE = re.compile(r"thumb\.php\?f=([^&\"']+)", re.I)
FILE_WIKI_RE = re.compile(r"\[\[(?:File|Image):([^|\]]+)", re.I)


def http_get(url: str, timeout: int = 25, retries: int = 4) -> bytes:
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    last = None
    for i in range(retries):
        try:
            with urllib.request.urlopen(req, context=CTX, timeout=timeout) as resp:
                return resp.read()
        except (urllib.error.URLError, TimeoutError, ssl.SSLError) as exc:
            last = exc
            time.sleep(0.4 * (i + 1))
    raise RuntimeError(f"GET failed {url}: {last}")


def discover_problems() -> list[dict]:
    items = []
    for md in sorted(ROOT.rglob("*.md")):
        if md.name == "README.md" or "_gen" in md.parts:
            continue
        if not re.match(r"\d{3}_", md.stem):
            continue
        text = md.read_text(encoding="utf-8")
        m = URL_RE.search(text)
        if not m:
            continue
        items.append(
            {
                "md": md,
                "stem": md.stem,
                "page": urllib.parse.unquote(m.group(1)),
            }
        )
    return items


def parse_page(page: str) -> dict:
    qs = urllib.parse.urlencode(
        {
            "action": "parse",
            "page": page,
            "prop": "images|wikitext|text",
            "disablelimitreport": "1",
            "format": "json",
        }
    )
    data = json.loads(http_get(f"{API}?{qs}"))
    if "error" in data:
        raise RuntimeError(f"{page}: {data['error']}")
    parsed = data["parse"]
    wikitext = parsed.get("wikitext", {}).get("*", "") or ""
    html = parsed.get("text", {}).get("*", "") or ""
    names = list(parsed.get("images") or [])
    for src in IMG_SRC_RE.findall(html):
        src = src.replace("&amp;", "&")
        if "logo" in src.lower() or "poweredby" in src.lower() or "resources/" in src:
            continue
        names.extend(MW_IMAGE_RE.findall(src))
        names.extend(urllib.parse.unquote(x) for x in THUMB_RE.findall(src))
    names.extend(n.strip() for n in FILE_WIKI_RE.findall(wikitext))
    clean = []
    seen = set()
    for name in names:
        name = name.strip().replace(" ", "_")
        low = name.lower()
        if any(s in low for s in SKIP_SUBSTR):
            continue
        if low in seen:
            continue
        seen.add(low)
        clean.append(name)
    waves = [w.strip() for w in WAVEDROM_RE.findall(wikitext) if w.strip()]
    return {"images": clean, "waves": waves, "page": page}


def ext_for(name: str, content: bytes, content_type: str | None) -> str:
    suffix = Path(name).suffix.lower()
    if suffix in {".png", ".gif", ".jpg", ".jpeg", ".svg", ".webp"}:
        return suffix
    ct = (content_type or "").split(";")[0].strip().lower()
    return {
        "image/png": ".png",
        "image/gif": ".gif",
        "image/jpeg": ".jpg",
        "image/svg+xml": ".svg",
        "image/webp": ".webp",
    }.get(ct, ".bin")


CACHE = Path("/tmp/hdlbits-img-cache")


def download_image(name: str) -> tuple[str, bytes]:
    CACHE.mkdir(parents=True, exist_ok=True)
    safe = name.replace("/", "_")
    cached = list(CACHE.glob(safe + ".*"))
    if cached:
        data = cached[0].read_bytes()
        return cached[0].suffix, data
    url = FILEPATH + urllib.parse.quote(name)
    req = urllib.request.Request(url, headers={"User-Agent": UA})
    last = None
    for i in range(4):
        try:
            with urllib.request.urlopen(req, context=CTX, timeout=30) as resp:
                data = resp.read()
                ctype = resp.headers.get("Content-Type")
                ext = ext_for(name, data, ctype)
                (CACHE / f"{safe}{ext}").write_bytes(data)
                return ext, data
        except (urllib.error.URLError, TimeoutError) as exc:
            last = exc
            time.sleep(0.4 * (i + 1))
    raise RuntimeError(f"image {name}: {last}")


def ensure_wavedrom_cli() -> Path:
    tool_dir = Path("/tmp/hdlbits-wavedrom")
    bin_path = tool_dir / "node_modules" / ".bin" / "wavedrom-cli"
    if not bin_path.exists():
        tool_dir.mkdir(parents=True, exist_ok=True)
        subprocess.run(
            ["npm", "install", "--silent", "wavedrom-cli@3.2.0"],
            cwd=tool_dir,
            check=True,
        )
    return bin_path


def drop_wavedrom_foot(source: str) -> str:
    """Remove WaveDrom `foot` objects whose tick labels don't survive JSON->JS well."""
    out = []
    i = 0
    key = re.compile(r'["\']?foot["\']?\s*:')
    while True:
        m = key.search(source, i)
        if not m:
            out.append(source[i:])
            break
        out.append(source[i:m.start()])
        j = m.end()
        while j < len(source) and source[j] in " \t\n,":
            j += 1
        if j >= len(source) or source[j] != "{":
            out.append(source[m.start() : m.end()])
            i = m.end()
            continue
        depth = 0
        k = j
        while k < len(source):
            if source[k] == "{":
                depth += 1
            elif source[k] == "}":
                depth -= 1
                if depth == 0:
                    k += 1
                    break
            k += 1
        chunk = "".join(out).rstrip().rstrip(",")
        out = [chunk]
        i = k
    return "".join(out)


def render_wavedrom(cli: Path, source: str, dest: Path) -> None:
    tmp = dest.with_suffix(".json")
    tmp.write_text(drop_wavedrom_foot(source), encoding="utf-8")
    try:
        subprocess.run(
            [str(cli), "-i", str(tmp), "-s", str(dest)],
            check=True,
            capture_output=True,
            text=True,
        )
    finally:
        if tmp.exists():
            tmp.unlink()


def patch_markdown(md_path: Path, stem: str) -> None:
    text = md_path.read_text(encoding="utf-8")
    fig = figures_markdown(md_path.parent, stem)
    md_path.write_text(insert_figures(text, fig), encoding="utf-8")


def main() -> None:
    problems = discover_problems()
    print(f"Found {len(problems)} problem pages", flush=True)
    parsed: dict[str, dict] = {}
    errors: list[str] = []

    def work(item: dict) -> tuple[str, dict | str]:
        try:
            return item["stem"], parse_page(item["page"])
        except Exception as exc:  # noqa: BLE001
            return item["stem"], f"{item['page']}: {exc}"

    with ThreadPoolExecutor(max_workers=5) as pool:
        futs = [pool.submit(work, it) for it in problems]
        done = 0
        for fut in as_completed(futs):
            stem, result = fut.result()
            done += 1
            if done % 25 == 0 or done == len(problems):
                print(f"  fetched {done}/{len(problems)}", flush=True)
            if isinstance(result, str):
                errors.append(result)
            else:
                parsed[stem] = result

    n_img = sum(len(v["images"]) for v in parsed.values())
    n_wave = sum(len(v["waves"]) for v in parsed.values())
    print(f"Discovered {n_img} raster/svg figures and {n_wave} WaveDrom blocks", flush=True)

    image_cache: dict[str, tuple[str, bytes]] = {}

    def fetch_one(name: str) -> tuple[str, tuple[str, bytes] | str]:
        try:
            return name, download_image(name)
        except Exception as exc:  # noqa: BLE001
            return name, str(exc)

    unique_images = sorted({n for v in parsed.values() for n in v["images"]})
    with ThreadPoolExecutor(max_workers=5) as pool:
        futs = [pool.submit(fetch_one, n) for n in unique_images]
        done = 0
        for fut in as_completed(futs):
            name, result = fut.result()
            done += 1
            if done % 20 == 0 or done == len(unique_images):
                print(f"  downloaded {done}/{len(unique_images)} unique images", flush=True)
            if isinstance(result, str):
                errors.append(f"download {name}: {result}")
            else:
                image_cache[name] = result

    cli = ensure_wavedrom_cli() if n_wave else None
    by_stem = {it["stem"]: it for it in problems}
    placed = 0
    waved = 0
    for stem, info in parsed.items():
        item = by_stem[stem]
        folder = item["md"].parent
        # remove previous generated media for this stem
        for old in list_old_media(folder, stem):
            old.unlink()
        fig_i = 0
        for name in info["images"]:
            if name not in image_cache:
                continue
            ext, data = image_cache[name]
            fig_i += 1
            dest = folder / f"{stem}_fig{fig_i}{ext}"
            dest.write_bytes(data)
            placed += 1
        for i, wave in enumerate(info["waves"], 1):
            dest = folder / f"{stem}_wave{i}.svg"
            try:
                render_wavedrom(cli, wave, dest)
                waved += 1
            except subprocess.CalledProcessError as exc:
                errors.append(f"wavedrom {stem} #{i}: {exc.stderr[-400:] if exc.stderr else exc}")
                if dest.exists():
                    dest.unlink()
        patch_markdown(item["md"], stem)

    manifest = {
        "problems": len(problems),
        "unique_images": len(image_cache),
        "files_written": placed,
        "waveforms_written": waved,
        "errors": errors,
        "pages": {
            stem: {"page": info["page"], "images": info["images"], "waves": len(info["waves"])}
            for stem, info in parsed.items()
        },
    }
    (Path(__file__).parent / "media_manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True), encoding="utf-8"
    )
    print(f"Wrote {placed} figures and {waved} waveforms. errors={len(errors)}")
    for e in errors[:20]:
        print(" ERR", e)
    if errors and placed == 0 and waved == 0:
        sys.exit(1)


def list_old_media(folder: Path, stem: str) -> list[Path]:
    files: list[Path] = []
    for pat in (f"{stem}_fig*.*", f"{stem}_wave*.*"):
        files.extend(folder.glob(pat))
    return files


if __name__ == "__main__":
    main()
