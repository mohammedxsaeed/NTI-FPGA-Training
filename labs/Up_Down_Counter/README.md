# Up/Down Counter

## 📝 Overview
A 2-bit counter with selectable direction (Up or Down) and asynchronous reset.

## 📊 Interface (I/O Ports)
| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| clock, reset | Input | 1-bit | System Clock and Reset |
| up | Input | 1-bit | Direction (1: Up, 0: Down) |
| count | Output | 2-bit | Current Counter Value |

## 📂 Structure
- **rtl/**: Verilog source code.
- **tb/**: Testbench for verification (if available).

---
*Part of the NTI FPGA Training Program.*
