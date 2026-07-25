# Bidirectional Memory

## 📝 Overview
Memory module utilizing a bidirectional data bus with tri-state control for read/write operations.

## 📊 Interface (I/O Ports)
| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| clk, wr, rd | Input | 1-bit | Control Signals |
| addr | Input | N-bit | Memory Address |
| data | Inout | 8-bit | Bidirectional Data Bus |

## 📂 Structure
- **rtl/**: Verilog source code.
- **tb/**: Testbench for verification (if available).

---
*Part of the NTI FPGA Training Program.*
