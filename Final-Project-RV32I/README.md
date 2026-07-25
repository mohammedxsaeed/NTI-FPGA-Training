# Single-Cycle RV32I RISC-V Processor

**NTI — Digital Design Using FPGA Training | Final Project**

[![Verilog](https://img.shields.io/badge/HDL-Verilog-blue)]()
[![Vivado](https://img.shields.io/badge/Tool-Xilinx%20Vivado-orange)]()
[![Status](https://img.shields.io/badge/Status-Simulated%20%2B%20FPGA%20Demo-brightgreen)]()

A working central processing unit built from scratch in Verilog, implementing a
restricted 14-instruction subset of the **RV32I** RISC-V instruction set architecture.
The core was verified through simulation and deployed on a physical FPGA
development board for a live hardware demo.

## Table of Contents

- [Overview](#overview)
- [Supported Instructions](#supported-instructions)
- [Architecture](#architecture)
- [Repository Structure](#repository-structure)
- [RTL Module Map](#rtl-module-map)
- [Test Programs](#test-programs)
- [How to Simulate](#how-to-simulate)
- [Team & Task Ownership](#team--task-ownership)
- [Documentation](#documentation)

## Overview

The processor follows a **single-cycle** design: every instruction — fetch,
decode, and execute — completes within one clock cycle. This is the simplest
processor architecture to design and verify, which made it realistic to build,
test, and demo within the training's 5-day timeline while still covering every
core building block of a real CPU: datapath, control logic, register file,
ALU, and memory.

**RISC-V / RV32I in brief:** RISC-V is an open, royalty-free instruction set
architecture. RV32I is its base 32-bit integer subset — 32-bit registers and
data paths, integer-only instructions (no multiply/divide, no floating point,
no compressed instructions). This project implements a further-restricted
14-instruction slice of RV32I covering all six instruction formats (R, I, S,
B, U, J) — enough to demonstrate arithmetic, memory access, and control flow.

Each clock cycle the processor performs, in parallel (not as separate stages):

- **Fetch** — the Program Counter supplies an address; Instruction Memory returns the instruction.
- **Decode** — the Control Unit reads the opcode/funct3/funct7 fields and generates control signals; the Register File supplies operands; the Immediate Generator extracts any embedded constant.
- **Execute** — the ALU computes the result (or Data Memory is read/written for loads/stores); the result is written back to the Register File, and the next PC value is computed.

## Supported Instructions

| Instruction | Type | Operation |
|---|---|---|
| `ADD` | R | `rd = rs1 + rs2` |
| `SUB` | R | `rd = rs1 − rs2` |
| `AND` / `OR` / `XOR` | R | bitwise logic |
| `SLT` | R | `rd = (rs1 < rs2) ? 1 : 0` |
| `SLL` / `SRL` / `SRA` | R | shifts (logical/arithmetic) |
| `ADDI` | I | `rd = rs1 + imm` |
| `LW` | I | `rd = MEM[rs1 + imm]` |
| `JALR` | I | `rd = PC+4 ; PC = (rs1+imm) & ~1` |
| `SW` | S | `MEM[rs1 + imm] = rs2` |
| `BEQ` | B | `if (rs1==rs2) PC += imm` |
| `BNE` | B | `if (rs1!=rs2) PC += imm` |
| `LUI` | U | `rd = imm << 12` |
| `JAL` | J | `rd = PC+4 ; PC += imm` |

## Architecture

The full single-cycle datapath — Program Counter, Instruction Memory, Control
Unit, ALU Control, Register File, Immediate Generator, ALU, Data Memory, and
the I/O interface — is diagrammed in [`docs/Final_Project_Report.pdf`](./docs/Final_Project_Report.pdf)
(Section 4), with the synthesized schematic in [`docs/schematic.pdf`](./docs/schematic.pdf).

```
                ┌──────────────┐
   pc_out ─────▶│ Instruction  │── instr[31:0] ──┬──▶ Control Unit ──▶ control signals
┌─▶│     PC     ││   Memory     │                  ├──▶ ALU Control ──▶ alu_ctrl
│  └──────────────┘              ├──▶ Register File ──▶ rs1_data, rs2_data
│                                 └──▶ Immediate Gen ──▶ imm_out
│                                                              │
│                                        ┌── ALUSrc mux ◀──────┘
│                                        ▼
│                                  ┌──────────┐     ┌────────────┐
│                                  │   ALU    │────▶│ Data Memory│──▶ MemtoReg mux ──▶ Register File (write-back)
│                                  └──────────┘     └────────────┘
│                                        │
└──── PC-source mux ◀── Branch/Jump target adder ◀──┘
```

## Repository Structure

```
Final-Project-RV32I/
├── rtl/          # Synthesizable Verilog modules (the processor itself)
├── tb/           # Testbenches — top-level and per-module
├── sim/          # ModelSim/Questa simulation script (run.do)
├── programs/     # Assembly test programs + hand-assembled hex machine code
└── docs/         # Final report and synthesized schematic
```

## RTL Module Map

| File | Module | Description |
|---|---|---|
| `rv32i_top.v` | Top-level datapath | Instantiates and wires every module below |
| `program_counter.v` | PC | Program counter register |
| `instr_memory.v` | Instruction Memory | ROM, loaded via `$readmemh` |
| `control_unit.v` | Control Unit | Opcode → control signals (RegWrite, MemWrite, Branch, Jump, ALUOp, ...) |
| `alu_control.v` | ALU Control | ALUOp + funct3 + funct7[5] → 4-bit `alu_ctrl` |
| `alu.v` | ALU | Arithmetic/logic unit with `zero` flag |
| `register_file.v` | Register File | 32×32, x0 hardwired to 0, sync write / combinational read |
| `imm_gen.v` | Immediate Generator | Sign-extension for I/S/B/U/J formats |
| `data_memory.v` | Data Memory | RAM, synchronous write |
| `mux32.v`, `mux32_2.v` | Multiplexers | ALUSrc, MemtoReg, PC-source selection |
| `pc_sel_logic.v` | PC-source logic | Selects next PC: sequential / branch / jump |
| `target_adder.v` | Branch/Jump adder | Computes branch/jump target address |
| `io_interface_7seg.v` | I/O | 7-segment display output for the FPGA demo |
| `io_interface_8leds.v` | I/O | 8-LED output for the FPGA demo |

### Testbenches (`tb/`)

| File | Scope | Purpose |
|---|---|---|
| `alu_tb.v` | Unit | Randomized ALU test (100 random operand/opcode combinations) |
| `control_path_tb.v` | Integration | Joint test of Control Unit + ALU Control together |
| `top_tb.v` | System | Full top-level testbench — runs the assembly test programs and checks final register/memory state |

## Test Programs

| Program | File | Tests |
|---|---|---|
| 1 | `program1_alu.s` | Arithmetic sequence (`ADD` / `SUB` / `ADDI`) |
| 2 | `program2_control.s` | Counting loop using `BNE` |
| 3 | `program3_mem.s` | Memory store/load round-trip (`SW` / `LW`) |
| 4 | `program4_control_flow.s` | Control flow — `BEQ`, `BNE`, `JAL` |

Each `.s` program (except #4) has a matching `.hex` file used to initialize
instruction memory via `$readmemh` in simulation.

## How to Simulate

1. Open ModelSim/Questa (or Vivado's built-in xsim).
2. Add every file in `rtl/` as a design source.
3. Add `tb/top_tb.v` (and optionally `tb/alu_tb.v`, `tb/control_path_tb.v`) as simulation sources.
4. Run the provided script:
   ```
   do sim/run.do
   ```
5. Inspect waveforms / `$display` output to verify register and memory state after each test program.

## Team & Task Ownership

| Member | Role |
|---|---|
| Mohammed Saeed Mohammed | Control Unit & ALU Control |
| Mohammed Awad-Allah Mohammed | ALU & Register File |
| Mario Mody Zaher | Immediate Generator & Memory Modules |
| Sagda Hossameldin Ibrahim | Top-Level Integration & PC/MUX/Branch Logic |
| Haroun Taha | Testbench, Assembly Programs, I/O & Documentation |

## Documentation

- [`docs/Final_Project_Report.pdf`](./docs/Final_Project_Report.pdf) — full spec: module port lists, ISA table, block diagram, integration checklist, deliverables.
- [`docs/schematic.pdf`](./docs/schematic.pdf) — post-synthesis schematic.
