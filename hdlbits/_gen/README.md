# HDLBits file generator

Python sources that emit the 182 problem files and fetch official figures.

```bash
python3 build.py          # write problem statements + solutions
python3 fetch_images.py   # download HDLBits figures and WaveDrom waveforms
```

`fetch_images.py` copies PNG/GIF diagrams from HDLBits and renders `<wavedrom>` blocks to SVG, then embeds them in each problem's markdown.

Do not import the `p0*.py` modules more than once in the same process; they write files at import time.
