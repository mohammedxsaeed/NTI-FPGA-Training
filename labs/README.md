# NTI FPGA Training: Labs Index

This directory contains the practical laboratory exercises completed during the training. Each lab is organized into `rtl` (source code), `tb` (testbenches), and a dedicated `README.md` explaining the module's function and interface.

## 📂 Labs Catalog

| Lab Directory | Core Module | Description |
| :--- | :--- | :--- |
| **[Day1_Full_Adder](./Day1_Full_Adder/)** | `Full_Adder` | Basic 1-bit full adder implementation. |
| **[Debouncing_Circuit](./Debouncing_Circuit/)** | `debouncing_circuit` | Mechanical noise filtering for switches. |
| **[Driver_Module](./Driver_Module/)** | `driver` | Parameterized data buffer with enable control. |
| **[Edge_Detector_FSM](./Edge_Detector_FSM/)** | `edge_detector` | State-machine based transition detection. |
| **[Even_Parity_Generator_Generate_Block](./Even_Parity_Generator_Generate_Block/)** | `even_parity_generate` | Scalable parity logic using generate blocks. |
| **[FSM_2_Segment](./FSM_2_Segment/)** | `FSM` | Standard 2-segment FSM coding pattern. |
| **[Generic_Counter](./Generic_Counter/)** | `counter` | Parameterized synchronous N-bit counter. |
| **[Lab03_ALU](./Lab03_ALU/)** | `ALU` | 8-bit Arithmetic Logic Unit with 16 operations. |
| **[Lab03_SIPO_ALU](./Lab03_SIPO_ALU/)** | `SIPO_ALU` | Integration of serial input with arithmetic logic. |
| **[Lab04_Top_System](./Lab04_Top_System/)** | `TOP_SYSTEM` | Complex integration of RAM, SIPO, and ALU. |
| **[Lab06_Controller](./Lab06_Controller/)** | `controller` | CPU control unit with opcode decoding. |
| **[Lab07_Register](./Lab07_Register/)** | `register` | Synchronous register with load and reset. |
| **[Lab08_Bidirectional_Memory](./Lab08_Bidirectional_Memory/)** | `memory` | Memory interface with inout data bus. |
| **[MUX](./MUX/)** | `Mux` | Parameterized 2-to-1 multiplexer. |
| **[Priority_Encoder](./Priority_Encoder/)** | `P_ENC` | High-priority input index encoder. |
| **[Rising_Edge_Detector](./Rising_Edge_Detector/)** | `Rising_edge` | Mealy/Moore rising edge detection. |
| **[Sequence_Detector_Overlapping_Nonoverlapping](./Sequence_Detector_Overlapping_Nonoverlapping/)** | `seq_detector` | Serial pattern recognition FSM. |
| **[Stream_Parity_Generator](./Stream_Parity_Generator/)** | `stream_parity_gen` | Time-based serial parity computation. |
| **[Up_Down_Counter](./Up_Down_Counter/)** | `counter2` | 2-bit up/down counter with async reset. |

---
*Refer to the individual README files in each subdirectory for detailed I/O port descriptions.*
