# Lab 03: 8-bit ALU

## 📝 Overview
A comprehensive Arithmetic Logic Unit supporting arithmetic, logical, and shift operations.

## 📊 Interface (I/O Ports)
| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| A, B | Input | 8-bit | Operands |
| ALU_Sel | Input | 4-bit | Operation Selector |
| ALU_Out | Output | 8-bit | Operation Result |
| CarryOut | Output | 1-bit | Carry Flag |

## 📂 Structure
- **rtl/**: Verilog source code.
- **tb/**: Testbench for verification (if available).

---
*Part of the NTI FPGA Training Program.*
