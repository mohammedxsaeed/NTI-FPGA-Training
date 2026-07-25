# NTI FPGA Training: Practical Labs Catalog

This directory contains the complete set of **19 Practical Labs** developed during the Digital Design and FPGA training at the **National Telecommunication Institute (NTI)**. These labs provide a hands-on foundation in digital logic, hardware description languages (Verilog), and FPGA implementation.

---

## 📂 Labs Overview

The labs are organized into specialized modules, each following a professional structure:
- **`rtl/`**: Clean, synthesizable Verilog source code.
- **`tb/`**: Testbenches for functional verification.
- **`README.md`**: Detailed documentation for each specific module.

### 🔬 Core Lab Modules

| Lab Category | Key Modules | Design Concepts |
| :--- | :--- | :--- |
| **Arithmetic & Logic** | `Lab03_ALU`, `Lab03_SIPO_ALU`, `Day1_Full_Adder` | Combinational design, arithmetic circuits, signed/unsigned logic. |
| **Sequential Design** | `Generic_Counter`, `Up_Down_Counter`, `Lab07_Register` | Synchronous logic, registers, parameterized counters. |
| **Finite State Machines** | `FSM_2_Segment`, `Sequence_Detector`, `Edge_Detector_FSM` | Moore & Mealy FSMs, sequence recognition, state encoding. |
| **Input/Output & Bus** | `Debouncing_Circuit`, `Lab08_Bidirectional_Memory`, `MUX` | Switch debouncing, tri-state buffers, bidirectional data buses. |
| **System Integration** | `Lab04_Top_System`, `Lab06_Controller`, `Driver_Module` | Top-level hierarchy, CPU control logic, system-level wiring. |

---

## 📖 Detailed Lab Descriptions

### [Lab 03: 8-bit ALU](./Lab03_ALU/)
A versatile Arithmetic Logic Unit capable of performing 16 operations (Add, Sub, Mul, Logic, Shifts).
- **Key I/O**: `A`, `B` (operands), `ALU_Sel` (selector) → `ALU_Out`, `CarryOut`.

### [Sequence Detector](./Sequence_Detector_Overlapping_Nonoverlapping/)
A complex FSM that detects a specific bit pattern in a serial stream, supporting both **Overlapping** and **Non-overlapping** detection modes.
- **Key I/O**: `clk`, `rst`, `serial_in` → `detect`.

### [Lab 08: Bidirectional Memory](./Lab08_Bidirectional_Memory/)
Demonstrates the use of `inout` ports and tri-state buffers to interface with a single-port RAM.
- **Key I/O**: `addr`, `wr`, `rd` → `data` (bidirectional bus).

### [Debouncing Circuit](./Debouncing_Circuit/)
A critical module for FPGA hardware, filtering high-frequency noise from mechanical push-buttons.
- **Key I/O**: `noisy_in` → `clean_out`.

---

## 🛠️ Tools & Simulation Environment

- **HDL**: Verilog-2001
- **Simulation**: Xilinx Vivado Simulator / ModelSim
- **Methodology**: Behavioral, Structural, and Dataflow modeling.

### How to use these labs:
1. Navigate to any lab directory.
2. Read the local `README.md` for specific I/O and functional details.
3. Open the RTL files in your preferred editor or FPGA suite.
4. Run the associated testbench in the `tb/` folder to verify behavior.

---
*Each lab represents a verified milestone in mastering FPGA-based digital design.*
