# NTI FPGA Training: Digital Design & RISC-V Implementation

Welcome to the comprehensive repository for the **Digital Design Using FPGA** training program, conducted at the **National Telecommunication Institute (NTI)**. This repository showcases a journey from fundamental digital logic blocks to the design and implementation of a fully functional 32-bit RISC-V processor.

## 🌟 Repository Highlights

This repository is organized into two main sections, each representing a significant phase of the training:

### 1. [Final Project: Single-Cycle RV32I Processor](./Final-Project-RV32I/)
A complete implementation of a **32-bit RISC-V (RV32I) Processor**. This project demonstrates advanced skills in hardware architecture, instruction set decoding, and system-level integration.
- **ISA**: RV32I (Base Integer Instruction Set).
- **Design**: Single-cycle datapath with modular RTL components.
- **Verification**: Validated using assembly programs and comprehensive testbenches.

### 2. [Practical Labs Catalog](./labs/)
A collection of 19 specialized labs covering essential digital design concepts. Each lab serves as a building block for complex system design:
- **Combinational Logic**: ALUs, Multiplexers, Priority Encoders.
- **Sequential Logic**: Registers, Up/Down Counters, Debouncing Circuits.
- **Finite State Machines (FSM)**: Sequence Detectors, Edge Detectors (Mealy/Moore).
- **System Integration**: Memory interfacing, SIPO/PISO modules, and top-level system controllers.

---

## 📂 Project Structure

```text
NTI-Training/
├── Final-Project-RV32I/      # The crown jewel: 32-bit RISC-V CPU
│   ├── rtl/                  # Verilog source code for all CPU modules
│   ├── tb/                   # Comprehensive testbenches
│   ├── programs/             # Assembly test programs and Hex files
│   └── docs/                 # Technical reports and schematics
├── labs/                     # 19 specialized digital design labs
│   ├── Lab03_ALU/            # Each lab has its own RTL, TB, and README
│   ├── FSM_2_Segment/
│   └── ...
└── .gitignore                # Optimized for Vivado, ModelSim, and Quartus
```

## 🛠️ Tools & Technologies
- **Hardware Description Language**: Verilog HDL
- **Design & Synthesis**: Xilinx Vivado Design Suite
- **Simulation**: ModelSim / QuestaSim
- **Architecture**: RISC-V Open ISA

---
*This repository serves as a professional portfolio for digital design and FPGA engineering skills acquired during the NTI training program.*
