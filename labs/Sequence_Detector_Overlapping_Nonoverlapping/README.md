# Sequence Detector

## 📝 Overview
A Finite State Machine (FSM) designed to detect a specific bit sequence in a serial data stream.

## 📊 Interface (I/O Ports)
| Port Name | Direction | Width | Description |
| :--- | :--- | :--- | :--- |
| clk, rst | Input | 1-bit | Clock and Async Reset |
| serial_in | Input | 1-bit | Serial Data Input |
| detect | Output | 1-bit | Pattern Detected Flag |

## 📂 Structure
- **rtl/**: Verilog source code.
- **tb/**: Testbench for verification (if available).

---
*Part of the NTI FPGA Training Program.*
