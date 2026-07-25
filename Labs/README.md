# NTI FPGA Training: Labs Documentation

This directory contains the various digital design labs completed during the training. Each lab focuses on a specific hardware design concept, ranging from basic combinational logic to complex finite state machines (FSMs) and memory interfacing.

---

## 📂 Labs Catalog

### 1. Arithmetic Logic Unit (ALU_LAB3)
*   **Function**: Performs various arithmetic and logical operations based on a selection code.
*   **Inputs**:
    *   `A`, `B` [8-bit]: Data operands.
    *   `ALU_Sel` [4-bit]: Operation selector.
*   **Outputs**:
    *   `ALU_Out` [8-bit]: Result of the operation.
    *   `CarryOut`: Carry flag for arithmetic operations.

### 2. Control Unit (Controller_LAB6)
*   **Function**: Decodes instructions and generates control signals for the datapath.
*   **Inputs**:
    *   `Opcode` [7-bit]: Instruction opcode.
*   **Outputs**:
    *   `RegWrite`, `MemWrite`, `ALUSrc`, `Branch`, etc.: Control signals for CPU components.

### 3. Full Adder (Day1)
*   **Function**: Basic 1-bit full adder implementation (Structural and Behavioral).
*   **Inputs**: `A`, `B`, `Cin`.
*   **Outputs**: `Sum`, `Cout`.

### 4. Input Debouncing (Debouncing_Circuit)
*   **Function**: Filters mechanical switch noise to provide a clean pulse for digital logic.
*   **Inputs**: `clk`, `rst`, `noisy_in`.
*   **Outputs**: `clean_out`.

### 5. Edge Detectors (Edge_detector_FSM & Rising_Edge_Detector)
*   **Function**: Detects transitions (rising/falling edges) in a serial input signal using FSMs.
*   **Inputs**: `clk`, `rst`, `level_in`.
*   **Outputs**: `edge_pulse`.

### 6. Parity Generators (Even_parity_Generator & stream_parity_gen)
*   **Function**: Generates a parity bit for a given data stream or bus.
*   **Inputs**: `clk`, `rst`, `serial_in` (or `bit_stream`).
*   **Outputs**: `parity_out`.

### 7. Finite State Machines (FSM_2_segment)
*   **Function**: Demonstrates standard FSM design patterns (Moore/Mealy) for sequence control.
*   **Inputs**: `clk`, `rst`, `in`.
*   **Outputs**: `out`.

### 8. Counters (Generic_Counter & up_down_counter)
*   **Function**: Implements parameterized and up/down counters with synchronous/asynchronous resets.
*   **Inputs**: `clk`, `rst`, `up_down_sel`.
*   **Outputs**: `count_out` [N-bit].

### 9. Bidirectional Memory (LAB8_Bidirectional_memory)
*   **Function**: Interfacing with memory using a bidirectional data bus (Tri-state buffers).
*   **Inputs**: `clk`, `addr`, `data_bus` (inout).
*   **Outputs**: `data_read`.

### 10. Multiplexers (MUX)
*   **Function**: Selects one of several input signals to be forwarded to a single output.
*   **Inputs**: `In0`, `In1`, `In2`, `In3`, `Sel`.
*   **Outputs**: `Out`.

### 11. Priority Encoder (Prirority_Encoder)
*   **Function**: Encodes the index of the highest-priority active input.
*   **Inputs**: `request_bus` [N-bit].
*   **Outputs**: `encoded_id`, `valid_flag`.

### 12. Register File (Register_LAB7)
*   **Function**: A collection of registers that can be read and written using addresses.
*   **Inputs**: `clk`, `write_en`, `write_addr`, `read_addr`, `data_in`.
*   **Outputs**: `data_out`.

### 13. Sequence Detector (Sequence_detector_overlapping_nonoverlapping)
*   **Function**: Detects a specific bit pattern (e.g., `1011`) in a serial stream, supporting both overlapping and non-overlapping modes.
*   **Inputs**: `clk`, `rst`, `serial_in`.
*   **Outputs**: `pattern_detected`.

---

## 🛠️ How to Simulate
Each lab directory contains a **Vivado Project (`.xpr`)** or a **ModelSim script (`run.do`)**. 
1. Open the project in **Xilinx Vivado**.
2. Locate the testbench file (usually ending in `_tb.v`).
3. Run **Behavioral Simulation** to verify the I/O behavior described above.
