"""Build all HDLBits tutorial files and the index READMEs."""
from __future__ import annotations

from collections import defaultdict
from pathlib import Path

from emit import CATALOG, ROOT

import p01_lang  # noqa: F401
import p02_combo  # noqa: F401
import p03_seq  # noqa: F401
import p04_fsm  # noqa: F401
import p04b_exam_fsm  # noqa: F401
import p05_verify  # noqa: F401


def write_section_readmes() -> None:
    by_dir: dict[str, list] = defaultdict(list)
    for item in CATALOG:
        by_dir[item["section_dir"]].append(item)

    for section_dir, items in by_dir.items():
        items = sorted(items, key=lambda x: x["num"])
        name = items[0]["section_name"]
        lines = [
            f"# {name}",
            "",
            "Problems are restated from [HDLBits](https://hdlbits.01xz.net/wiki/Problem_sets). "
            "Each `.md` file includes the Verilog solution; the matching `.v` file is the same `top_module`.",
            "",
            "| # | Problem | Files |",
            "|---|---------|-------|",
        ]
        for it in items:
            lines.append(
                f"| {it['num']:03d} | [{it['title']}]({it['url']}) | "
                f"[md](./{it['mname']}) · [v](./{it['vname']}) |"
            )
        lines.append("")
        (ROOT / section_dir / "README.md").write_text("\n".join(lines), encoding="utf-8")


def write_root_readme() -> None:
    by_name: dict[str, list] = defaultdict(list)
    for item in CATALOG:
        by_name[item["section_name"]].append(item)

    # Preserve first-seen section order.
    order = []
    seen = set()
    for item in CATALOG:
        n = item["section_name"]
        if n not in seen:
            seen.add(n)
            order.append(n)

    lines = [
        "# HDLBits problem set",
        "",
        "This directory contains **all 182 problems** from "
        "[HDLBits](https://hdlbits.01xz.net/wiki/Main_Page) "
        "([problem index](https://hdlbits.01xz.net/wiki/Problem_sets)).",
        "",
        "## How to use these files",
        "",
        "1. Read the `.md` file for a restated problem statement, official figures, the Verilog solution, and a link to the HDLBits page.",
        "2. The matching `.v` file is the same `top_module`, ready to compile or paste into HDLBits.",
        "3. Submit on HDLBits to get the official interactive checker.",
        "4. For problems that instantiate a module HDLBits provides (`mod_a`, `add16`, …), "
        "compile with the matching file under [`helpers/`](./helpers/) for local simulation. "
        "**Do not paste helper modules into the HDLBits editor.**",
        "",
        "## Attribution",
        "",
        "HDLBits is a Verilog practice site by Henry Wong (University of Toronto) at "
        "[hdlbits.01xz.net](https://hdlbits.01xz.net/wiki/Main_Page). "
        "Problem titles, module templates, and numbering follow the public problem set. "
        "The statements here are **restated in our own words** for this tutorial; "
        "circuit diagrams, K-maps, and WaveDrom waveforms are copied from HDLBits into each "
        "problem's markdown file. "
        "The interactive tester still lives on HDLBits. "
        "The Verilog in this folder was written for this repository (not copied from HDLBits' hidden reference files).",
        "",
        "## Simulate locally",
        "",
        "```bash",
        "cd hdlbits",
        "# Example: simple combinational problem (no helpers)",
        "iverilog -o /tmp/t.vvp 02_verilog_language/01_basics/003_wire.v",
        "",
        "# Example: needs a provided module",
        "iverilog -o /tmp/t.vvp helpers/add16.v \\",
        "  02_verilog_language/03_modules/025_module_add.v",
        "```",
        "",
        "Many solutions have no testbench because HDLBits supplies the vectors. "
        "The original tutorial examples still live in [`../examples/`](../examples/).",
        "",
        "K-maps, exam figures, and \"build from a waveform\" problems include the official "
        "HDLBits images (PNG/GIF) and WaveDrom waveforms (SVG) next to each problem statement. "
        "A few problems on the site have no figure (text-only). Re-fetch with "
        "`python3 fetch_images.py` in `_gen/`.",
        "",
        f"## Index ({len(CATALOG)} problems)",
        "",
    ]
    for name in order:
        items = sorted(by_name[name], key=lambda x: x["num"])
        rel = items[0]["section_dir"]
        lines.append(f"### {name}")
        lines.append("")
        lines.append(f"Folder: [`{rel}/`](./{rel}/)")
        lines.append("")
        for it in items:
            lines.append(
                f"- **{it['num']:03d}.** [{it['title']}]({it['url']}) — "
                f"[`{it['vname']}`](./{rel}/{it['vname']})"
            )
        lines.append("")

    (ROOT / "README.md").write_text("\n".join(lines), encoding="utf-8")


def main() -> None:
    nums = [x["num"] for x in CATALOG]
    missing = [i for i in range(1, 183) if i not in nums]
    extra = [n for n in nums if n < 1 or n > 182]
    dup = sorted({n for n in nums if nums.count(n) > 1})
    if missing or extra or dup:
        raise SystemExit(f"catalog error missing={missing} extra={extra} dup={dup} count={len(nums)}")
    write_section_readmes()
    write_root_readme()
    print(f"Wrote {len(CATALOG)} problems under {ROOT}")


if __name__ == "__main__":
    main()
