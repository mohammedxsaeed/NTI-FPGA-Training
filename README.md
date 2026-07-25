# NTI FPGA Training: Digital Design & RISC-V Implementation

This repository contains the complete work from the **Digital Design Using FPGA** training program at the **National Telecommunication Institute (NTI)**. It includes fundamental digital design labs and a final project implementing a RISC-V processor.

## 📂 Repository Structure

- **[Single-Cycle-RV32I/](./Single-Cycle-RV32I/)**: The final project - A 32-bit RISC-V processor implementation.
- **[Labs/](./Labs/)**: A collection of labs covering various digital design concepts (ALUs, FSMs, Counters, etc.).

## 🚀 Final Project: Single-Cycle RV32I Processor

The core of this repository is a **Single-Cycle 32-bit RISC-V (RV32I) Processor**. 

### Highlights:
- **ISA**: Supports a subset of RV32I instructions (Arithmetic, Logic, Memory, Control Flow).
- **Design**: Fully implemented in Verilog with a clean, modular architecture.
- **Verification**: Verified using a comprehensive testbench and assembly programs.
- **FPGA Ready**: Synthesizable and tested on FPGA hardware.

For more details on the processor design, instruction set, and simulation instructions, please refer to the [Single-Cycle-RV32I README](./Single-Cycle-RV32I/README.md).

## 📚 Training Labs Overview

The `Labs/` directory contains various modules implemented during the training:

| Lab | Description | Key Concepts |
| :--- | :--- | :--- |
| `alu_lab3` | Arithmetic Logic Unit | Combinational logic, arithmetic operations. |
| `fsm_2_segment` | 2-Segment Finite State Machine | Sequential logic, state transitions. |
| `sequence_detector` | Overlapping/Non-overlapping Detector | FSM design, pattern matching. |
| `generic_counter` | Parameterized Counter | Synchronous design, parameters. |
| `debouncing_circuit` | Input Debouncer | Hardware interfacing, clock division. |
| `lab8_bidir_memory` | Bidirectional Memory | Memory interfacing, tri-state buffers. |

## 🛠️ Tools & Technologies
- **Hardware Description Language**: Verilog HDL
- **Synthesis & Simulation**: Xilinx Vivado, ModelSim, Quartus
- **Architecture**: RISC-V (RV32I)

---
*Completed as part of the NTI Digital Design Training Program.*
