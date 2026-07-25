# NTI Training — Digital Design Using FPGA

This repository contains all labs and the final team project from the
**National Telecommunication Institute (NTI)** "Digital Design Using FPGA"
training program — Verilog RTL design, simulation, and FPGA deployment.

## ⭐ Featured: Final Project

**[Single-Cycle RV32I RISC-V Processor](./Final-Project-RV32I)** — a working
CPU implementing a 14-instruction subset of RV32I, designed in Verilog,
verified in simulation, and deployed on FPGA for a live demo. See its
[dedicated README](./Final-Project-RV32I/README.md) for the full write-up.

## Labs

| # | Lab | Topic |
|---|---|---|
| 1 | [Day1_Full_Adder](./labs/Day1_Full_Adder) | Full adder — dataflow / structural / hierarchical |
| 2 | [MUX](./labs/MUX) | Parameterized multiplexer |
| 3 | [Priority_Encoder](./labs/Priority_Encoder) | Priority encoder (two variants) |
| 4 | [Generic_Counter](./labs/Generic_Counter) | Parameterized counter |
| 5 | [Debouncing_Circuit](./labs/Debouncing_Circuit) | Switch debouncer |
| 6 | [Rising_Edge_Detector](./labs/Rising_Edge_Detector) | Edge detector — Mealy vs. Moore |
| 7 | [Edge_Detector_FSM](./labs/Edge_Detector_FSM) | FSM-based edge detector |
| 8 | [FSM_2_Segment](./labs/FSM_2_Segment) | FSM-driven 7-segment display |
| 9 | [Sequence_Detector_Overlapping_Nonoverlapping](./labs/Sequence_Detector_Overlapping_Nonoverlapping) | Sequence detectors — overlapping/non-overlapping, Mealy/Moore |
| 10 | [Even_Parity_Generator_Generate_Block](./labs/Even_Parity_Generator_Generate_Block) | Parity generator using `generate` blocks |
| 11 | [Stream_Parity_Generator](./labs/Stream_Parity_Generator) | Streaming parity generator |
| 12 | [Up_Down_Counter](./labs/Up_Down_Counter) | Up/down counter — behavioral/structural/gate-level |
| 13 | [Lab03_ALU](./labs/Lab03_ALU) | Standalone ALU |
| 14 | [Lab03_SIPO_ALU](./labs/Lab03_SIPO_ALU) | SIPO + PISO + RAM + ALU system |
| 15 | [Lab04_Top_System](./labs/Lab04_Top_System) | Full top-level system integration |
| 16 | [Lab06_Controller](./labs/Lab06_Controller) | Controller / control unit |
| 17 | [Lab07_Register](./labs/Lab07_Register) | Parameterized register |
| 18 | [Lab08_Bidirectional_Memory](./labs/Lab08_Bidirectional_Memory) | Bidirectional memory |
| 19 | [Driver_Module](./labs/Driver_Module) | Parameterized output driver |

Each lab folder contains its own `README.md`, an `rtl/` folder with the
synthesizable Verilog sources, and a `tb/` folder with testbenches where one
was written.

## Repository Structure

```
NTI-Training/
├── README.md
├── .gitignore
├── Final-Project-RV32I/     ← the flagship final project
│   ├── README.md
│   ├── rtl/
│   ├── tb/
│   ├── sim/
│   ├── programs/
│   └── docs/
└── labs/
    ├── Day1_Full_Adder/
    ├── MUX/
    ├── ...
    └── Driver_Module/
```

## Tools Used

- Verilog HDL
- Xilinx Vivado (design, synthesis, FPGA deployment, and simulation)
- ModelSim / Questa (waveform simulation for the final project)

## Author

Mohammed — Electronics & Communication Engineering, Helwan University
