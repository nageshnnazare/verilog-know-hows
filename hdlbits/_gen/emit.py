#!/usr/bin/env python3
"""Emit HDLBits tutorial files: one Verilog solution + one markdown note per problem."""
from __future__ import annotations

import re
from pathlib import Path
from textwrap import dedent

ROOT = Path(__file__).resolve().parents[1]

FIGURE_SECTION_RE = re.compile(
    r"\n## Figures \(from HDLBits\)\n.*?(?=\n## |\Z)",
    re.S,
)


def wrap_verilog(num: int, title: str, url: str, statement: str, code: str) -> str:
    stmt = dedent(statement).strip()
    # Keep problem text in comments without wrapping the source code.
    comment = "\n".join("// " + line if line else "//" for line in stmt.splitlines())
    header = dedent(
        f"""\
        //==============================================================================
        // HDLBits {num:03d} — {title}
        // Official problem: {url}
        //
        // The wording below is a restatement for this tutorial. Figures from the
        // official page are in the matching .md file. Use HDLBits for the
        // interactive checker.
        //
        // HDLBits always names the user module `top_module`. Port names match the
        // official template so you can paste this file into the HDLBits editor.
        //==============================================================================
        //
        """
    )
    return header + comment + "\n//\n\n" + dedent(code).strip() + "\n"


def solution_markdown(vname: str, code: str) -> str:
    body = dedent(code).strip()
    return (
        "## Solution\n\n"
        "The module is named `top_module` so you can paste it into HDLBits. "
        f"The same source is in [`{vname}`](./{vname}).\n\n"
        "```verilog\n"
        f"{body}\n"
        "```\n"
    )


def list_figure_files(directory: Path, stem: str) -> list[Path]:
    files: list[Path] = []
    for pat in (f"{stem}_fig*.*", f"{stem}_wave*.*"):
        files.extend(sorted(p for p in directory.glob(pat) if p.is_file()))
    return files


def figures_markdown(directory: Path, stem: str) -> str:
    files = list_figure_files(directory, stem)
    if not files:
        return ""
    lines = [
        "## Figures (from HDLBits)",
        "",
        "Copied from the official HDLBits problem page for this tutorial.",
        "",
    ]
    fig_i = 0
    wave_i = 0
    for path in files:
        if "_wave" in path.name:
            wave_i += 1
            lines.append(f"![Waveform {wave_i}](./{path.name})")
        else:
            fig_i += 1
            lines.append(f"![Figure {fig_i}](./{path.name})")
        lines.append("")
    return "\n".join(lines) + "\n"


def insert_figures(md: str, fig_md: str) -> str:
    md = FIGURE_SECTION_RE.sub("\n", md)
    if not fig_md.strip():
        return md
    if re.search(r"\n## (Notes|Solution)\n", md):
        return re.sub(
            r"\n## (Notes|Solution)\n",
            "\n" + fig_md + "## \\1\n",
            md,
            count=1,
        )
    return md.rstrip() + "\n\n" + fig_md


def write_problem(
    *,
    num: int,
    section_dir: str,
    filename: str,
    title: str,
    url: str,
    section_name: str,
    statement: str,
    code: str,
    notes: str = "",
) -> dict:
    d = ROOT / section_dir
    d.mkdir(parents=True, exist_ok=True)
    vname = f"{num:03d}_{filename}.v"
    mname = f"{num:03d}_{filename}.md"
    (d / vname).write_text(wrap_verilog(num, title, url, statement, code), encoding="utf-8")
    md = (
        f"# {num:03d}. {title}\n\n"
        f"**Section:** {section_name}  \n"
        f"**HDLBits:** [{title}]({url})\n\n"
        f"## Problem\n\n"
        f"{dedent(statement).strip()}\n"
    )
    extra = dedent(notes).strip()
    if extra:
        md += f"\n## Notes\n\n{extra}\n"
    md += "\n" + solution_markdown(vname, code)
    md = insert_figures(md, figures_markdown(d, f"{num:03d}_{filename}"))
    (d / mname).write_text(md, encoding="utf-8")
    return {
        "num": num,
        "title": title,
        "url": url,
        "section_dir": section_dir,
        "section_name": section_name,
        "filename": filename,
        "vname": vname,
        "mname": mname,
    }


CATALOG: list[dict] = []


def add(**kwargs):
    CATALOG.append(write_problem(**kwargs))
