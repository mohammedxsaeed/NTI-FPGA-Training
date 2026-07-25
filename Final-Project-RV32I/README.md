# Final Project: Single-Cycle RV32I RISC-V Processor

**NTI — Digital Design Using FPGA Training | Final Project**

[![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)]()
[![Vivado](https://img.shields.io/badge/Tool-Xilinx%20Vivado-orange)]()
[![Status](https://img.shields.io/badge/Status-Simulated%20%2B%20FPGA%20Demo-brightgreen)]()

This project represents the successful design and implementation of a **32-bit Single-Cycle RISC-V Processor**. Built from scratch using Verilog HDL, it implements a core 14-instruction subset of the **RV32I Base Integer ISA**. The design was rigorously verified through simulation and successfully deployed on a physical FPGA development board.

---

## 🌟 Project Overview

The processor follows a **single-cycle architecture**, where each instruction — fetch, decode, and execute — completes within one clock cycle. This project demonstrates the fundamental building blocks of computer architecture, including the datapath, control logic, register file, ALU, and memory management.

### Key Highlights:
- **ISA**: Supports R, I, S, B, U, and J instruction formats.
- **Verification**: Verified via assembly test programs and randomized unit testbenches.
- **Hardware Demo**: Synthesized and tested on FPGA with 7-segment and LED visual feedback.

---

## 🏗️ Architecture & Datapath

The CPU architecture is designed for modularity and clarity. Each component handles a specific part of the instruction execution flow.

### Instruction Set (ISA) Support:
| Instruction | Type | Operation | Description |
| :--- | :--- | :--- | :--- |
| `ADD`, `SUB`, `SLT` | R | `rd = rs1 [op] rs2` | Arithmetic operations |
| `AND`, `OR`, `XOR` | R | bitwise logic | Logical operations |
| `SLL`, `SRL`, `SRA` | R | shifts | Logical and arithmetic shifts |
| `ADDI`, `LUI` | I/U | `rd = rs1 + imm` | Immediate operations |
| `LW`, `SW` | I/S | `MEM[addr]` | Memory Load and Store |
| `BEQ`, `BNE` | B | `if (cond) PC += imm` | Conditional Branching |
| `JAL`, `JALR` | J/I | `PC = target` | Unconditional Jumps |

---

## 📂 Repository Structure

```text
Final-Project-RV32I/
├── rtl/          # Synthesizable Verilog modules (The CPU Core)
├── tb/           # Testbenches for unit and system verification
├── sim/          # ModelSim/Questa simulation scripts (run.do)
├── programs/     # Assembly test programs and machine code (.hex)
└── docs/         # Technical report and hardware schematics
```

---

## 🛠️ RTL Module Map & I/O Specifications

| File | Module | Function | Key I/O Ports |
| :--- | :--- | :--- | :--- |
| `rv32i_top.v` | **Top-Level** | System integration | `clk`, `rst`, `led_out`, `seg_out` |
| `control_unit.v`| **Control Unit**| Opcode decoding | `opcode`, `RegWrite`, `MemWrite`, `Branch` |
| `alu.v` | **ALU** | Arithmetic/Logic | `A`, `B`, `ALUControl` -> `ALUResult`, `Zero` |
| `register_file.v`| **Reg File** | 32x32 Registers | `rs1`, `rs2`, `rd`, `WriteData` -> `rs1_data`, `rs2_data`|
| `imm_gen.v` | **Imm Gen** | Sign-extension | `instr[31:7]` -> `imm_out` |
| `instr_memory.v`| **ROM** | Instruction storage| `addr` -> `instr` (Loaded via .hex) |
| `data_memory.v` | **RAM** | Data storage | `addr`, `WriteData`, `MemRead`, `MemWrite` |

---

## 🧪 Verification & Simulation

The processor was verified using a series of targeted assembly programs:
- **`program1_alu.s`**: Validates basic arithmetic and logic operations.
- **`program2_control.s`**: Tests loop execution and conditional branching (`BNE`).
- **`program3_mem.s`**: Verifies data integrity for memory access (`LW`/`SW`).

### How to Simulate:
1. Load all files in `rtl/` and `tb/` into your simulator (Vivado/ModelSim).
2. Run the top-level testbench `top_tb.v`.
3. Use the provided script for automated simulation:
   ```bash
   vsim -do sim/run.do
   ```

---

## 👥 Team & Contributions

| Member | Responsibility |
| :--- | :--- |
| **Mohammed Saeed** | Control Unit & ALU Control Logic |
| **Mohammed Awad-Allah** | ALU Design & Register File Implementation |
| **Mario Mody** | Immediate Generator & Memory Modules |
| **Sagda Hossameldin** | Top-Level Integration & Branching Logic |
| **Haroun Taha** | Testbench, Assembly Programs & Documentation |

---

## 📜 Documentation
Detailed design analysis, block diagrams, and synthesized schematics are available in the [docs/](./docs/) folder:
- **[Final Project Report.pdf](./docs/Final_Project_Report.pdf)**
- **[Schematic.pdf](./docs/schematic.pdf)**

---
*Completed as the Final Project for the NTI FPGA Training Program.*
