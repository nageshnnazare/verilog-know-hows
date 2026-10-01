# HDLBits problem set

This directory contains **all 182 problems** from [HDLBits](https://hdlbits.01xz.net/wiki/Main_Page) ([problem index](https://hdlbits.01xz.net/wiki/Problem_sets)).

## How to use these files

1. Read the `.md` file for a restated problem statement, official figures, the Verilog solution, and a link to the HDLBits page.
2. The matching `.v` file is the same `top_module`, ready to compile or paste into HDLBits.
3. Submit on HDLBits to get the official interactive checker.
4. For problems that instantiate a module HDLBits provides (`mod_a`, `add16`, …), compile with the matching file under [`helpers/`](./helpers/) for local simulation. **Do not paste helper modules into the HDLBits editor.**

## Attribution

HDLBits is a Verilog practice site by Henry Wong (University of Toronto) at [hdlbits.01xz.net](https://hdlbits.01xz.net/wiki/Main_Page). Problem titles, module templates, and numbering follow the public problem set. The statements here are **restated in our own words** for this tutorial; circuit diagrams, K-maps, and WaveDrom waveforms are copied from HDLBits into each problem's markdown file. The interactive tester still lives on HDLBits. The Verilog in this folder was written for this repository (not copied from HDLBits' hidden reference files).

## Simulate locally

```bash
cd hdlbits
# Example: simple combinational problem (no helpers)
iverilog -o /tmp/t.vvp 02_verilog_language/01_basics/003_wire.v

# Example: needs a provided module
iverilog -o /tmp/t.vvp helpers/add16.v \
  02_verilog_language/03_modules/025_module_add.v
```

Many solutions have no testbench because HDLBits supplies the vectors. The original tutorial examples still live in [`../examples/`](../examples/).

K-maps, exam figures, and "build from a waveform" problems include the official HDLBits images (PNG/GIF) and WaveDrom waveforms (SVG) next to each problem statement. A few problems on the site have no figure (text-only). Re-fetch with `python3 fetch_images.py` in `_gen/`.

## Index (182 problems)

### Getting Started

Folder: [`01_getting_started/`](./01_getting_started/)

- **001.** [Getting Started (Step one)](https://hdlbits.01xz.net/wiki/Step_one) — [`001_step_one.v`](./01_getting_started/001_step_one.v)
- **002.** [Output Zero](https://hdlbits.01xz.net/wiki/Zero) — [`002_zero.v`](./01_getting_started/002_zero.v)

### Verilog Language — Basics

Folder: [`02_verilog_language/01_basics/`](./02_verilog_language/01_basics/)

- **003.** [Simple wire](https://hdlbits.01xz.net/wiki/Wire) — [`003_wire.v`](./02_verilog_language/01_basics/003_wire.v)
- **004.** [Four wires](https://hdlbits.01xz.net/wiki/Wire4) — [`004_wire4.v`](./02_verilog_language/01_basics/004_wire4.v)
- **005.** [Inverter](https://hdlbits.01xz.net/wiki/Notgate) — [`005_notgate.v`](./02_verilog_language/01_basics/005_notgate.v)
- **006.** [AND gate](https://hdlbits.01xz.net/wiki/Andgate) — [`006_andgate.v`](./02_verilog_language/01_basics/006_andgate.v)
- **007.** [NOR gate](https://hdlbits.01xz.net/wiki/Norgate) — [`007_norgate.v`](./02_verilog_language/01_basics/007_norgate.v)
- **008.** [XNOR gate](https://hdlbits.01xz.net/wiki/Xnorgate) — [`008_xnorgate.v`](./02_verilog_language/01_basics/008_xnorgate.v)
- **009.** [Declaring wires](https://hdlbits.01xz.net/wiki/Wire_decl) — [`009_wire_decl.v`](./02_verilog_language/01_basics/009_wire_decl.v)
- **010.** [7458 chip](https://hdlbits.01xz.net/wiki/7458) — [`010_chip7458.v`](./02_verilog_language/01_basics/010_chip7458.v)

### Verilog Language — Vectors

Folder: [`02_verilog_language/02_vectors/`](./02_verilog_language/02_vectors/)

- **011.** [Vectors](https://hdlbits.01xz.net/wiki/Vector0) — [`011_vector0.v`](./02_verilog_language/02_vectors/011_vector0.v)
- **012.** [Vectors in more detail](https://hdlbits.01xz.net/wiki/Vector1) — [`012_vector1.v`](./02_verilog_language/02_vectors/012_vector1.v)
- **013.** [Vector part select](https://hdlbits.01xz.net/wiki/Vector2) — [`013_vector2.v`](./02_verilog_language/02_vectors/013_vector2.v)
- **014.** [Bitwise operators](https://hdlbits.01xz.net/wiki/Vectorgates) — [`014_vectorgates.v`](./02_verilog_language/02_vectors/014_vectorgates.v)
- **015.** [Four-input gates](https://hdlbits.01xz.net/wiki/Gates4) — [`015_gates4.v`](./02_verilog_language/02_vectors/015_gates4.v)
- **016.** [Vector concatenation operator](https://hdlbits.01xz.net/wiki/Vector3) — [`016_vector3.v`](./02_verilog_language/02_vectors/016_vector3.v)
- **017.** [Vector reversal 1](https://hdlbits.01xz.net/wiki/Vectorr) — [`017_vectorr.v`](./02_verilog_language/02_vectors/017_vectorr.v)
- **018.** [Replication operator](https://hdlbits.01xz.net/wiki/Vector4) — [`018_vector4.v`](./02_verilog_language/02_vectors/018_vector4.v)
- **019.** [More replication](https://hdlbits.01xz.net/wiki/Vector5) — [`019_vector5.v`](./02_verilog_language/02_vectors/019_vector5.v)

### Verilog Language — Modules: Hierarchy

Folder: [`02_verilog_language/03_modules/`](./02_verilog_language/03_modules/)

- **020.** [Modules](https://hdlbits.01xz.net/wiki/Module) — [`020_module.v`](./02_verilog_language/03_modules/020_module.v)
- **021.** [Connecting ports by position](https://hdlbits.01xz.net/wiki/Module_pos) — [`021_module_pos.v`](./02_verilog_language/03_modules/021_module_pos.v)
- **022.** [Connecting ports by name](https://hdlbits.01xz.net/wiki/Module_name) — [`022_module_name.v`](./02_verilog_language/03_modules/022_module_name.v)
- **023.** [Three modules](https://hdlbits.01xz.net/wiki/Module_shift) — [`023_module_shift.v`](./02_verilog_language/03_modules/023_module_shift.v)
- **024.** [Modules and vectors](https://hdlbits.01xz.net/wiki/Module_shift8) — [`024_module_shift8.v`](./02_verilog_language/03_modules/024_module_shift8.v)
- **025.** [Adder 1](https://hdlbits.01xz.net/wiki/Module_add) — [`025_module_add.v`](./02_verilog_language/03_modules/025_module_add.v)
- **026.** [Adder 2](https://hdlbits.01xz.net/wiki/Module_fadd) — [`026_module_fadd.v`](./02_verilog_language/03_modules/026_module_fadd.v)
- **027.** [Carry-select adder](https://hdlbits.01xz.net/wiki/Module_cseladd) — [`027_module_cseladd.v`](./02_verilog_language/03_modules/027_module_cseladd.v)
- **028.** [Adder-subtractor](https://hdlbits.01xz.net/wiki/Module_addsub) — [`028_module_addsub.v`](./02_verilog_language/03_modules/028_module_addsub.v)

### Verilog Language — Procedures

Folder: [`02_verilog_language/04_procedures/`](./02_verilog_language/04_procedures/)

- **029.** [Always blocks (combinational)](https://hdlbits.01xz.net/wiki/Alwaysblock1) — [`029_alwaysblock1.v`](./02_verilog_language/04_procedures/029_alwaysblock1.v)
- **030.** [Always blocks (clocked)](https://hdlbits.01xz.net/wiki/Alwaysblock2) — [`030_alwaysblock2.v`](./02_verilog_language/04_procedures/030_alwaysblock2.v)
- **031.** [If statement](https://hdlbits.01xz.net/wiki/Always_if) — [`031_always_if.v`](./02_verilog_language/04_procedures/031_always_if.v)
- **032.** [If statement latches](https://hdlbits.01xz.net/wiki/Always_if2) — [`032_always_if2.v`](./02_verilog_language/04_procedures/032_always_if2.v)
- **033.** [Case statement](https://hdlbits.01xz.net/wiki/Always_case) — [`033_always_case.v`](./02_verilog_language/04_procedures/033_always_case.v)
- **034.** [Priority encoder](https://hdlbits.01xz.net/wiki/Always_case2) — [`034_always_case2.v`](./02_verilog_language/04_procedures/034_always_case2.v)
- **035.** [Priority encoder with casez](https://hdlbits.01xz.net/wiki/Always_casez) — [`035_always_casez.v`](./02_verilog_language/04_procedures/035_always_casez.v)
- **036.** [Avoiding latches](https://hdlbits.01xz.net/wiki/Always_nolatches) — [`036_always_nolatches.v`](./02_verilog_language/04_procedures/036_always_nolatches.v)

### Verilog Language — More Verilog Features

Folder: [`02_verilog_language/05_more_features/`](./02_verilog_language/05_more_features/)

- **037.** [Conditional ternary operator](https://hdlbits.01xz.net/wiki/Conditional) — [`037_conditional.v`](./02_verilog_language/05_more_features/037_conditional.v)
- **038.** [Reduction operators](https://hdlbits.01xz.net/wiki/Reduction) — [`038_reduction.v`](./02_verilog_language/05_more_features/038_reduction.v)
- **039.** [Reduction: Even wider gates](https://hdlbits.01xz.net/wiki/Gates100) — [`039_gates100.v`](./02_verilog_language/05_more_features/039_gates100.v)
- **040.** [Combinational for-loop: Vector reversal 2](https://hdlbits.01xz.net/wiki/Vector100r) — [`040_vector100r.v`](./02_verilog_language/05_more_features/040_vector100r.v)
- **041.** [Combinational for-loop: 255-bit population count](https://hdlbits.01xz.net/wiki/Popcount255) — [`041_popcount255.v`](./02_verilog_language/05_more_features/041_popcount255.v)
- **042.** [Generate for-loop: 100-bit binary adder 2](https://hdlbits.01xz.net/wiki/Adder100i) — [`042_adder100i.v`](./02_verilog_language/05_more_features/042_adder100i.v)
- **043.** [Generate for-loop: 100-digit BCD adder](https://hdlbits.01xz.net/wiki/Bcdadd100) — [`043_bcdadd100.v`](./02_verilog_language/05_more_features/043_bcdadd100.v)

### Circuits — Combinational Logic — Basic Gates

Folder: [`03_circuits/01_combinational/01_basic_gates/`](./03_circuits/01_combinational/01_basic_gates/)

- **044.** [Wire](https://hdlbits.01xz.net/wiki/Exams/m2014_q4h) — [`044_m2014_q4h.v`](./03_circuits/01_combinational/01_basic_gates/044_m2014_q4h.v)
- **045.** [GND](https://hdlbits.01xz.net/wiki/Exams/m2014_q4i) — [`045_m2014_q4i.v`](./03_circuits/01_combinational/01_basic_gates/045_m2014_q4i.v)
- **046.** [NOR](https://hdlbits.01xz.net/wiki/Exams/m2014_q4e) — [`046_m2014_q4e.v`](./03_circuits/01_combinational/01_basic_gates/046_m2014_q4e.v)
- **047.** [Another gate](https://hdlbits.01xz.net/wiki/Exams/m2014_q4f) — [`047_m2014_q4f.v`](./03_circuits/01_combinational/01_basic_gates/047_m2014_q4f.v)
- **048.** [Two gates](https://hdlbits.01xz.net/wiki/Exams/m2014_q4g) — [`048_m2014_q4g.v`](./03_circuits/01_combinational/01_basic_gates/048_m2014_q4g.v)
- **049.** [More logic gates](https://hdlbits.01xz.net/wiki/Gates) — [`049_gates.v`](./03_circuits/01_combinational/01_basic_gates/049_gates.v)
- **050.** [7420 chip](https://hdlbits.01xz.net/wiki/7420) — [`050_chip7420.v`](./03_circuits/01_combinational/01_basic_gates/050_chip7420.v)
- **051.** [Truth tables](https://hdlbits.01xz.net/wiki/Truthtable1) — [`051_truthtable1.v`](./03_circuits/01_combinational/01_basic_gates/051_truthtable1.v)
- **052.** [Two-bit equality](https://hdlbits.01xz.net/wiki/Mt2015_eq2) — [`052_mt2015_eq2.v`](./03_circuits/01_combinational/01_basic_gates/052_mt2015_eq2.v)
- **053.** [Simple circuit A](https://hdlbits.01xz.net/wiki/Mt2015_q4a) — [`053_mt2015_q4a.v`](./03_circuits/01_combinational/01_basic_gates/053_mt2015_q4a.v)
- **054.** [Simple circuit B](https://hdlbits.01xz.net/wiki/Mt2015_q4b) — [`054_mt2015_q4b.v`](./03_circuits/01_combinational/01_basic_gates/054_mt2015_q4b.v)
- **055.** [Combine circuits A and B](https://hdlbits.01xz.net/wiki/Mt2015_q4) — [`055_mt2015_q4.v`](./03_circuits/01_combinational/01_basic_gates/055_mt2015_q4.v)
- **056.** [Ring or vibrate?](https://hdlbits.01xz.net/wiki/Ringer) — [`056_ringer.v`](./03_circuits/01_combinational/01_basic_gates/056_ringer.v)
- **057.** [Thermostat](https://hdlbits.01xz.net/wiki/Thermostat) — [`057_thermostat.v`](./03_circuits/01_combinational/01_basic_gates/057_thermostat.v)
- **058.** [3-bit population count](https://hdlbits.01xz.net/wiki/Popcount3) — [`058_popcount3.v`](./03_circuits/01_combinational/01_basic_gates/058_popcount3.v)
- **059.** [Gates and vectors](https://hdlbits.01xz.net/wiki/Gatesv) — [`059_gatesv.v`](./03_circuits/01_combinational/01_basic_gates/059_gatesv.v)
- **060.** [Even longer vectors](https://hdlbits.01xz.net/wiki/Gatesv100) — [`060_gatesv100.v`](./03_circuits/01_combinational/01_basic_gates/060_gatesv100.v)

### Circuits — Combinational Logic — Multiplexers

Folder: [`03_circuits/01_combinational/02_multiplexers/`](./03_circuits/01_combinational/02_multiplexers/)

- **061.** [2-to-1 multiplexer](https://hdlbits.01xz.net/wiki/Mux2to1) — [`061_mux2to1.v`](./03_circuits/01_combinational/02_multiplexers/061_mux2to1.v)
- **062.** [2-to-1 bus multiplexer](https://hdlbits.01xz.net/wiki/Mux2to1v) — [`062_mux2to1v.v`](./03_circuits/01_combinational/02_multiplexers/062_mux2to1v.v)
- **063.** [9-to-1 multiplexer](https://hdlbits.01xz.net/wiki/Mux9to1v) — [`063_mux9to1v.v`](./03_circuits/01_combinational/02_multiplexers/063_mux9to1v.v)
- **064.** [256-to-1 multiplexer](https://hdlbits.01xz.net/wiki/Mux256to1) — [`064_mux256to1.v`](./03_circuits/01_combinational/02_multiplexers/064_mux256to1.v)
- **065.** [256-to-1 4-bit multiplexer](https://hdlbits.01xz.net/wiki/Mux256to1v) — [`065_mux256to1v.v`](./03_circuits/01_combinational/02_multiplexers/065_mux256to1v.v)

### Circuits — Combinational Logic — Arithmetic Circuits

Folder: [`03_circuits/01_combinational/03_arithmetic/`](./03_circuits/01_combinational/03_arithmetic/)

- **066.** [Half adder](https://hdlbits.01xz.net/wiki/Hadd) — [`066_hadd.v`](./03_circuits/01_combinational/03_arithmetic/066_hadd.v)
- **067.** [Full adder](https://hdlbits.01xz.net/wiki/Fadd) — [`067_fadd.v`](./03_circuits/01_combinational/03_arithmetic/067_fadd.v)
- **068.** [3-bit binary adder](https://hdlbits.01xz.net/wiki/Adder3) — [`068_adder3.v`](./03_circuits/01_combinational/03_arithmetic/068_adder3.v)
- **069.** [Adder](https://hdlbits.01xz.net/wiki/Exams/m2014_q4j) — [`069_m2014_q4j.v`](./03_circuits/01_combinational/03_arithmetic/069_m2014_q4j.v)
- **070.** [Signed addition overflow](https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q1c) — [`070_ece241_2014_q1c.v`](./03_circuits/01_combinational/03_arithmetic/070_ece241_2014_q1c.v)
- **071.** [100-bit binary adder](https://hdlbits.01xz.net/wiki/Adder100) — [`071_adder100.v`](./03_circuits/01_combinational/03_arithmetic/071_adder100.v)
- **072.** [4-digit BCD adder](https://hdlbits.01xz.net/wiki/Bcdadd4) — [`072_bcdadd4.v`](./03_circuits/01_combinational/03_arithmetic/072_bcdadd4.v)

### Circuits — Combinational Logic — Karnaugh Map to Circuit

Folder: [`03_circuits/01_combinational/04_karnaugh_maps/`](./03_circuits/01_combinational/04_karnaugh_maps/)

- **073.** [3-variable](https://hdlbits.01xz.net/wiki/Kmap1) — [`073_kmap1.v`](./03_circuits/01_combinational/04_karnaugh_maps/073_kmap1.v)
- **074.** [4-variable](https://hdlbits.01xz.net/wiki/Kmap2) — [`074_kmap2.v`](./03_circuits/01_combinational/04_karnaugh_maps/074_kmap2.v)
- **075.** [4-variable (don't-cares)](https://hdlbits.01xz.net/wiki/Kmap3) — [`075_kmap3.v`](./03_circuits/01_combinational/04_karnaugh_maps/075_kmap3.v)
- **076.** [4-variable (XOR of all)](https://hdlbits.01xz.net/wiki/Kmap4) — [`076_kmap4.v`](./03_circuits/01_combinational/04_karnaugh_maps/076_kmap4.v)
- **077.** [Minimum SOP and POS](https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q2) — [`077_ece241_2013_q2.v`](./03_circuits/01_combinational/04_karnaugh_maps/077_ece241_2013_q2.v)
- **078.** [Karnaugh map](https://hdlbits.01xz.net/wiki/Exams/m2014_q3) — [`078_m2014_q3.v`](./03_circuits/01_combinational/04_karnaugh_maps/078_m2014_q3.v)
- **079.** [Karnaugh map](https://hdlbits.01xz.net/wiki/Exams/2012_q1g) — [`079_2012_q1g.v`](./03_circuits/01_combinational/04_karnaugh_maps/079_2012_q1g.v)
- **080.** [K-map implemented with a multiplexer](https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q3) — [`080_ece241_2014_q3.v`](./03_circuits/01_combinational/04_karnaugh_maps/080_ece241_2014_q3.v)

### Circuits — Sequential Logic — Latches and Flip-Flops

Folder: [`03_circuits/02_sequential/01_latches_ff/`](./03_circuits/02_sequential/01_latches_ff/)

- **081.** [D flip-flop](https://hdlbits.01xz.net/wiki/Dff) — [`081_dff.v`](./03_circuits/02_sequential/01_latches_ff/081_dff.v)
- **082.** [D flip-flops](https://hdlbits.01xz.net/wiki/Dff8) — [`082_dff8.v`](./03_circuits/02_sequential/01_latches_ff/082_dff8.v)
- **083.** [DFF with reset](https://hdlbits.01xz.net/wiki/Dff8r) — [`083_dff8r.v`](./03_circuits/02_sequential/01_latches_ff/083_dff8r.v)
- **084.** [DFF with reset value](https://hdlbits.01xz.net/wiki/Dff8p) — [`084_dff8p.v`](./03_circuits/02_sequential/01_latches_ff/084_dff8p.v)
- **085.** [DFF with asynchronous reset](https://hdlbits.01xz.net/wiki/Dff8ar) — [`085_dff8ar.v`](./03_circuits/02_sequential/01_latches_ff/085_dff8ar.v)
- **086.** [DFF with byte enable](https://hdlbits.01xz.net/wiki/Dff16e) — [`086_dff16e.v`](./03_circuits/02_sequential/01_latches_ff/086_dff16e.v)
- **087.** [D Latch](https://hdlbits.01xz.net/wiki/Exams/m2014_q4a) — [`087_m2014_q4a.v`](./03_circuits/02_sequential/01_latches_ff/087_m2014_q4a.v)
- **088.** [DFF](https://hdlbits.01xz.net/wiki/Exams/m2014_q4b) — [`088_m2014_q4b.v`](./03_circuits/02_sequential/01_latches_ff/088_m2014_q4b.v)
- **089.** [DFF](https://hdlbits.01xz.net/wiki/Exams/m2014_q4c) — [`089_m2014_q4c.v`](./03_circuits/02_sequential/01_latches_ff/089_m2014_q4c.v)
- **090.** [DFF+gate](https://hdlbits.01xz.net/wiki/Exams/m2014_q4d) — [`090_m2014_q4d.v`](./03_circuits/02_sequential/01_latches_ff/090_m2014_q4d.v)
- **091.** [Mux and DFF](https://hdlbits.01xz.net/wiki/Mt2015_muxdff) — [`091_mt2015_muxdff.v`](./03_circuits/02_sequential/01_latches_ff/091_mt2015_muxdff.v)
- **092.** [Mux and DFF](https://hdlbits.01xz.net/wiki/Exams/2014_q4a) — [`092_2014_q4a.v`](./03_circuits/02_sequential/01_latches_ff/092_2014_q4a.v)
- **093.** [DFFs and gates](https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q4) — [`093_ece241_2014_q4.v`](./03_circuits/02_sequential/01_latches_ff/093_ece241_2014_q4.v)
- **094.** [Create circuit from truth table](https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q7) — [`094_ece241_2013_q7.v`](./03_circuits/02_sequential/01_latches_ff/094_ece241_2013_q7.v)
- **095.** [Detect an edge](https://hdlbits.01xz.net/wiki/Edgedetect) — [`095_edgedetect.v`](./03_circuits/02_sequential/01_latches_ff/095_edgedetect.v)
- **096.** [Detect both edges](https://hdlbits.01xz.net/wiki/Edgedetect2) — [`096_edgedetect2.v`](./03_circuits/02_sequential/01_latches_ff/096_edgedetect2.v)
- **097.** [Edge capture register](https://hdlbits.01xz.net/wiki/Edgecapture) — [`097_edgecapture.v`](./03_circuits/02_sequential/01_latches_ff/097_edgecapture.v)
- **098.** [Dual-edge triggered flip-flop](https://hdlbits.01xz.net/wiki/Dualedge) — [`098_dualedge.v`](./03_circuits/02_sequential/01_latches_ff/098_dualedge.v)

### Circuits — Sequential Logic — Counters

Folder: [`03_circuits/02_sequential/02_counters/`](./03_circuits/02_sequential/02_counters/)

- **099.** [Four-bit binary counter](https://hdlbits.01xz.net/wiki/Count15) — [`099_count15.v`](./03_circuits/02_sequential/02_counters/099_count15.v)
- **100.** [Decade counter](https://hdlbits.01xz.net/wiki/Count10) — [`100_count10.v`](./03_circuits/02_sequential/02_counters/100_count10.v)
- **101.** [Decade counter again](https://hdlbits.01xz.net/wiki/Count1to10) — [`101_count1to10.v`](./03_circuits/02_sequential/02_counters/101_count1to10.v)
- **102.** [Slow decade counter](https://hdlbits.01xz.net/wiki/Countslow) — [`102_countslow.v`](./03_circuits/02_sequential/02_counters/102_countslow.v)
- **103.** [Counter 1-12](https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7a) — [`103_ece241_2014_q7a.v`](./03_circuits/02_sequential/02_counters/103_ece241_2014_q7a.v)
- **104.** [Counter 1000](https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7b) — [`104_ece241_2014_q7b.v`](./03_circuits/02_sequential/02_counters/104_ece241_2014_q7b.v)
- **105.** [4-digit decimal counter](https://hdlbits.01xz.net/wiki/Countbcd) — [`105_countbcd.v`](./03_circuits/02_sequential/02_counters/105_countbcd.v)
- **106.** [12-hour clock](https://hdlbits.01xz.net/wiki/Count_clock) — [`106_count_clock.v`](./03_circuits/02_sequential/02_counters/106_count_clock.v)

### Circuits — Sequential Logic — Shift Registers

Folder: [`03_circuits/02_sequential/03_shift_registers/`](./03_circuits/02_sequential/03_shift_registers/)

- **107.** [4-bit shift register](https://hdlbits.01xz.net/wiki/Shift4) — [`107_shift4.v`](./03_circuits/02_sequential/03_shift_registers/107_shift4.v)
- **108.** [Left/right rotator](https://hdlbits.01xz.net/wiki/Rotate100) — [`108_rotate100.v`](./03_circuits/02_sequential/03_shift_registers/108_rotate100.v)
- **109.** [Left/right arithmetic shift by 1 or 8](https://hdlbits.01xz.net/wiki/Shift18) — [`109_shift18.v`](./03_circuits/02_sequential/03_shift_registers/109_shift18.v)
- **110.** [5-bit LFSR](https://hdlbits.01xz.net/wiki/Lfsr5) — [`110_lfsr5.v`](./03_circuits/02_sequential/03_shift_registers/110_lfsr5.v)
- **111.** [3-bit LFSR](https://hdlbits.01xz.net/wiki/Mt2015_lfsr) — [`111_mt2015_lfsr.v`](./03_circuits/02_sequential/03_shift_registers/111_mt2015_lfsr.v)
- **112.** [32-bit LFSR](https://hdlbits.01xz.net/wiki/Lfsr32) — [`112_lfsr32.v`](./03_circuits/02_sequential/03_shift_registers/112_lfsr32.v)
- **113.** [Shift register](https://hdlbits.01xz.net/wiki/Exams/m2014_q4k) — [`113_m2014_q4k.v`](./03_circuits/02_sequential/03_shift_registers/113_m2014_q4k.v)
- **114.** [Shift register](https://hdlbits.01xz.net/wiki/Exams/2014_q4b) — [`114_2014_q4b.v`](./03_circuits/02_sequential/03_shift_registers/114_2014_q4b.v)
- **115.** [3-input LUT](https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q12) — [`115_ece241_2013_q12.v`](./03_circuits/02_sequential/03_shift_registers/115_ece241_2013_q12.v)

### Circuits — Sequential Logic — More Circuits

Folder: [`03_circuits/02_sequential/04_more_circuits/`](./03_circuits/02_sequential/04_more_circuits/)

- **116.** [Rule 90](https://hdlbits.01xz.net/wiki/Rule90) — [`116_rule90.v`](./03_circuits/02_sequential/04_more_circuits/116_rule90.v)
- **117.** [Rule 110](https://hdlbits.01xz.net/wiki/Rule110) — [`117_rule110.v`](./03_circuits/02_sequential/04_more_circuits/117_rule110.v)
- **118.** [Conway's Game of Life 16x16](https://hdlbits.01xz.net/wiki/Conwaylife) — [`118_conwaylife.v`](./03_circuits/02_sequential/04_more_circuits/118_conwaylife.v)

### Circuits — Sequential Logic — Finite State Machines

Folder: [`03_circuits/02_sequential/05_fsm/`](./03_circuits/02_sequential/05_fsm/)

- **119.** [Simple FSM 1 (asynchronous reset)](https://hdlbits.01xz.net/wiki/Fsm1) — [`119_fsm1.v`](./03_circuits/02_sequential/05_fsm/119_fsm1.v)
- **120.** [Simple FSM 1 (synchronous reset)](https://hdlbits.01xz.net/wiki/Fsm1s) — [`120_fsm1s.v`](./03_circuits/02_sequential/05_fsm/120_fsm1s.v)
- **121.** [Simple FSM 2 (asynchronous reset)](https://hdlbits.01xz.net/wiki/Fsm2) — [`121_fsm2.v`](./03_circuits/02_sequential/05_fsm/121_fsm2.v)
- **122.** [Simple FSM 2 (synchronous reset)](https://hdlbits.01xz.net/wiki/Fsm2s) — [`122_fsm2s.v`](./03_circuits/02_sequential/05_fsm/122_fsm2s.v)
- **123.** [Simple state transitions 3](https://hdlbits.01xz.net/wiki/Fsm3comb) — [`123_fsm3comb.v`](./03_circuits/02_sequential/05_fsm/123_fsm3comb.v)
- **124.** [Simple one-hot state transitions 3](https://hdlbits.01xz.net/wiki/Fsm3onehot) — [`124_fsm3onehot.v`](./03_circuits/02_sequential/05_fsm/124_fsm3onehot.v)
- **125.** [Simple FSM 3 (asynchronous reset)](https://hdlbits.01xz.net/wiki/Fsm3) — [`125_fsm3.v`](./03_circuits/02_sequential/05_fsm/125_fsm3.v)
- **126.** [Simple FSM 3 (synchronous reset)](https://hdlbits.01xz.net/wiki/Fsm3s) — [`126_fsm3s.v`](./03_circuits/02_sequential/05_fsm/126_fsm3s.v)
- **127.** [Design a Moore FSM](https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q4) — [`127_ece241_2013_q4.v`](./03_circuits/02_sequential/05_fsm/127_ece241_2013_q4.v)
- **128.** [Lemmings 1](https://hdlbits.01xz.net/wiki/Lemmings1) — [`128_lemmings1.v`](./03_circuits/02_sequential/05_fsm/128_lemmings1.v)
- **129.** [Lemmings 2](https://hdlbits.01xz.net/wiki/Lemmings2) — [`129_lemmings2.v`](./03_circuits/02_sequential/05_fsm/129_lemmings2.v)
- **130.** [Lemmings 3](https://hdlbits.01xz.net/wiki/Lemmings3) — [`130_lemmings3.v`](./03_circuits/02_sequential/05_fsm/130_lemmings3.v)
- **131.** [Lemmings 4](https://hdlbits.01xz.net/wiki/Lemmings4) — [`131_lemmings4.v`](./03_circuits/02_sequential/05_fsm/131_lemmings4.v)
- **132.** [One-hot FSM](https://hdlbits.01xz.net/wiki/Fsm_onehot) — [`132_fsm_onehot.v`](./03_circuits/02_sequential/05_fsm/132_fsm_onehot.v)
- **133.** [PS/2 packet parser](https://hdlbits.01xz.net/wiki/Fsm_ps2) — [`133_fsm_ps2.v`](./03_circuits/02_sequential/05_fsm/133_fsm_ps2.v)
- **134.** [PS/2 packet parser and datapath](https://hdlbits.01xz.net/wiki/Fsm_ps2data) — [`134_fsm_ps2data.v`](./03_circuits/02_sequential/05_fsm/134_fsm_ps2data.v)
- **135.** [Serial receiver](https://hdlbits.01xz.net/wiki/Fsm_serial) — [`135_fsm_serial.v`](./03_circuits/02_sequential/05_fsm/135_fsm_serial.v)
- **136.** [Serial receiver and datapath](https://hdlbits.01xz.net/wiki/Fsm_serialdata) — [`136_fsm_serialdata.v`](./03_circuits/02_sequential/05_fsm/136_fsm_serialdata.v)
- **137.** [Serial receiver with parity checking](https://hdlbits.01xz.net/wiki/Fsm_serialdp) — [`137_fsm_serialdp.v`](./03_circuits/02_sequential/05_fsm/137_fsm_serialdp.v)
- **138.** [Sequence recognition](https://hdlbits.01xz.net/wiki/Fsm_hdlc) — [`138_fsm_hdlc.v`](./03_circuits/02_sequential/05_fsm/138_fsm_hdlc.v)
- **139.** [Q8: Design a Mealy FSM](https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q8) — [`139_ece241_2013_q8.v`](./03_circuits/02_sequential/05_fsm/139_ece241_2013_q8.v)
- **140.** [Q5a: Serial two's complementer (Moore FSM)](https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q5a) — [`140_ece241_2014_q5a.v`](./03_circuits/02_sequential/05_fsm/140_ece241_2014_q5a.v)
- **141.** [Q5b: Serial two's complementer (Mealy FSM)](https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q5b) — [`141_ece241_2014_q5b.v`](./03_circuits/02_sequential/05_fsm/141_ece241_2014_q5b.v)
- **142.** [Q3a: FSM](https://hdlbits.01xz.net/wiki/Exams/2014_q3fsm) — [`142_2014_q3fsm.v`](./03_circuits/02_sequential/05_fsm/142_2014_q3fsm.v)
- **143.** [Q3b: FSM](https://hdlbits.01xz.net/wiki/Exams/2014_q3bfsm) — [`143_2014_q3bfsm.v`](./03_circuits/02_sequential/05_fsm/143_2014_q3bfsm.v)
- **144.** [Q3c: FSM logic](https://hdlbits.01xz.net/wiki/Exams/2014_q3c) — [`144_2014_q3c.v`](./03_circuits/02_sequential/05_fsm/144_2014_q3c.v)
- **145.** [Q6b: FSM next-state logic](https://hdlbits.01xz.net/wiki/Exams/m2014_q6b) — [`145_m2014_q6b.v`](./03_circuits/02_sequential/05_fsm/145_m2014_q6b.v)
- **146.** [Q6c: FSM one-hot next-state logic](https://hdlbits.01xz.net/wiki/Exams/m2014_q6c) — [`146_m2014_q6c.v`](./03_circuits/02_sequential/05_fsm/146_m2014_q6c.v)
- **147.** [Q6: FSM](https://hdlbits.01xz.net/wiki/Exams/m2014_q6) — [`147_m2014_q6.v`](./03_circuits/02_sequential/05_fsm/147_m2014_q6.v)
- **148.** [Q2a: FSM](https://hdlbits.01xz.net/wiki/Exams/2012_q2fsm) — [`148_2012_q2fsm.v`](./03_circuits/02_sequential/05_fsm/148_2012_q2fsm.v)
- **149.** [Q2b: One-hot FSM equations](https://hdlbits.01xz.net/wiki/Exams/2012_q2b) — [`149_2012_q2b.v`](./03_circuits/02_sequential/05_fsm/149_2012_q2b.v)
- **150.** [Q2a: FSM](https://hdlbits.01xz.net/wiki/Exams/2013_q2afsm) — [`150_2013_q2afsm.v`](./03_circuits/02_sequential/05_fsm/150_2013_q2afsm.v)
- **151.** [Q2b: Another FSM](https://hdlbits.01xz.net/wiki/Exams/2013_q2bfsm) — [`151_2013_q2bfsm.v`](./03_circuits/02_sequential/05_fsm/151_2013_q2bfsm.v)

### Circuits — Building Larger Circuits

Folder: [`03_circuits/03_building_larger/`](./03_circuits/03_building_larger/)

- **152.** [Counter with period 1000](https://hdlbits.01xz.net/wiki/Exams/review2015_count1k) — [`152_review2015_count1k.v`](./03_circuits/03_building_larger/152_review2015_count1k.v)
- **153.** [4-bit shift register and down counter](https://hdlbits.01xz.net/wiki/Exams/review2015_shiftcount) — [`153_review2015_shiftcount.v`](./03_circuits/03_building_larger/153_review2015_shiftcount.v)
- **154.** [FSM: Sequence 1101 recognizer](https://hdlbits.01xz.net/wiki/Exams/review2015_fsmseq) — [`154_review2015_fsmseq.v`](./03_circuits/03_building_larger/154_review2015_fsmseq.v)
- **155.** [FSM: Enable shift register](https://hdlbits.01xz.net/wiki/Exams/review2015_fsmshift) — [`155_review2015_fsmshift.v`](./03_circuits/03_building_larger/155_review2015_fsmshift.v)
- **156.** [FSM: The complete FSM](https://hdlbits.01xz.net/wiki/Exams/review2015_fsm) — [`156_review2015_fsm.v`](./03_circuits/03_building_larger/156_review2015_fsm.v)
- **157.** [The complete timer](https://hdlbits.01xz.net/wiki/Exams/review2015_fancytimer) — [`157_review2015_fancytimer.v`](./03_circuits/03_building_larger/157_review2015_fancytimer.v)
- **158.** [FSM: One-hot logic equations](https://hdlbits.01xz.net/wiki/Exams/review2015_fsmonehot) — [`158_review2015_fsmonehot.v`](./03_circuits/03_building_larger/158_review2015_fsmonehot.v)

### Verification — Finding bugs in code

Folder: [`04_verification/01_bugs/`](./04_verification/01_bugs/)

- **159.** [Mux](https://hdlbits.01xz.net/wiki/Bugs_mux2) — [`159_bugs_mux2.v`](./04_verification/01_bugs/159_bugs_mux2.v)
- **160.** [NAND](https://hdlbits.01xz.net/wiki/Bugs_nand3) — [`160_bugs_nand3.v`](./04_verification/01_bugs/160_bugs_nand3.v)
- **161.** [Mux](https://hdlbits.01xz.net/wiki/Bugs_mux4) — [`161_bugs_mux4.v`](./04_verification/01_bugs/161_bugs_mux4.v)
- **162.** [Add/sub](https://hdlbits.01xz.net/wiki/Bugs_addsubz) — [`162_bugs_addsubz.v`](./04_verification/01_bugs/162_bugs_addsubz.v)
- **163.** [Case statement](https://hdlbits.01xz.net/wiki/Bugs_case) — [`163_bugs_case.v`](./04_verification/01_bugs/163_bugs_case.v)

### Verification — Build a circuit from a simulation waveform

Folder: [`04_verification/02_waveforms/`](./04_verification/02_waveforms/)

- **164.** [Combinational circuit 1](https://hdlbits.01xz.net/wiki/Sim/circuit1) — [`164_circuit1.v`](./04_verification/02_waveforms/164_circuit1.v)
- **165.** [Combinational circuit 2](https://hdlbits.01xz.net/wiki/Sim/circuit2) — [`165_circuit2.v`](./04_verification/02_waveforms/165_circuit2.v)
- **166.** [Combinational circuit 3](https://hdlbits.01xz.net/wiki/Sim/circuit3) — [`166_circuit3.v`](./04_verification/02_waveforms/166_circuit3.v)
- **167.** [Combinational circuit 4](https://hdlbits.01xz.net/wiki/Sim/circuit4) — [`167_circuit4.v`](./04_verification/02_waveforms/167_circuit4.v)
- **168.** [Combinational circuit 5](https://hdlbits.01xz.net/wiki/Sim/circuit5) — [`168_circuit5.v`](./04_verification/02_waveforms/168_circuit5.v)
- **169.** [Combinational circuit 6](https://hdlbits.01xz.net/wiki/Sim/circuit6) — [`169_circuit6.v`](./04_verification/02_waveforms/169_circuit6.v)
- **170.** [Sequential circuit 7](https://hdlbits.01xz.net/wiki/Sim/circuit7) — [`170_circuit7.v`](./04_verification/02_waveforms/170_circuit7.v)
- **171.** [Sequential circuit 8](https://hdlbits.01xz.net/wiki/Sim/circuit8) — [`171_circuit8.v`](./04_verification/02_waveforms/171_circuit8.v)
- **172.** [Sequential circuit 9](https://hdlbits.01xz.net/wiki/Sim/circuit9) — [`172_circuit9.v`](./04_verification/02_waveforms/172_circuit9.v)
- **173.** [Sequential circuit 10](https://hdlbits.01xz.net/wiki/Sim/circuit10) — [`173_circuit10.v`](./04_verification/02_waveforms/173_circuit10.v)

### Verification — Writing Testbenches

Folder: [`05_verification_testbenches/`](./05_verification_testbenches/)

- **174.** [Clock](https://hdlbits.01xz.net/wiki/Tb/clock) — [`174_tb_clock.v`](./05_verification_testbenches/174_tb_clock.v)
- **175.** [Testbench1](https://hdlbits.01xz.net/wiki/Tb/tb1) — [`175_tb_tb1.v`](./05_verification_testbenches/175_tb_tb1.v)
- **176.** [AND gate](https://hdlbits.01xz.net/wiki/Tb/and) — [`176_tb_and.v`](./05_verification_testbenches/176_tb_and.v)
- **177.** [Testbench2](https://hdlbits.01xz.net/wiki/Tb/tb2) — [`177_tb_tb2.v`](./05_verification_testbenches/177_tb_tb2.v)
- **178.** [T flip-flop](https://hdlbits.01xz.net/wiki/Tb/tff) — [`178_tb_tff.v`](./05_verification_testbenches/178_tb_tff.v)

### CS450

Folder: [`06_cs450/`](./06_cs450/)

- **179.** [Timer](https://hdlbits.01xz.net/wiki/Cs450/timer) — [`179_timer.v`](./06_cs450/179_timer.v)
- **180.** [Counter 2bc](https://hdlbits.01xz.net/wiki/Cs450/counter_2bc) — [`180_counter_2bc.v`](./06_cs450/180_counter_2bc.v)
- **181.** [History shift](https://hdlbits.01xz.net/wiki/Cs450/history_shift) — [`181_history_shift.v`](./06_cs450/181_history_shift.v)
- **182.** [Gshare](https://hdlbits.01xz.net/wiki/Cs450/gshare) — [`182_gshare.v`](./06_cs450/182_gshare.v)
