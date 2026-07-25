# Single-Cycle RV32I RISC-V Processor

This project implements a **Single-Cycle 32-bit RISC-V Processor** supporting a subset of the RV32I base integer instruction set. It was designed and verified as the final project for the NTI FPGA Training program.

## 🏗️ Architecture & Design

The processor follows a classic single-cycle architecture where each instruction is fetched, decoded, and executed within a single clock cycle.

### Supported Instruction Set (ISA)
The implementation supports 14 core instructions across different formats:
- **R-Type**: `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLT`, `SLL`, `SRL`, `SRA`
- **I-Type**: `ADDI`, `LW`, `JALR`
- **S-Type**: `SW`
- **B-Type**: `BEQ`, `BNE`
- **U-Type**: `LUI`
- **J-Type**: `JAL`

### Module Map
The design is highly modular, with each file in `RTL_Design/` representing a specific hardware block:
- `rv32i_top.v`: The top-level module integrating all components.
- `control_unit.v`: Main decoder for generating control signals.
- `alu_control.v`: Generates the specific ALU operation code.
- `alu.v`: Performs arithmetic and logical operations.
- `register_file.v`: 32x32-bit general-purpose registers.
- `imm_gen.v`: Extracts and sign-extends immediates from instructions.
- `instr_memory.v`: Stores the machine code (loaded via `.hex` files).
- `data_memory.v`: Data storage for Load/Store operations.
- `program_counter.v`: Manages the current instruction address.

## 🧪 Simulation & Verification

### Testbench
The main testbench is located at `TB/top_tb.v`. It instantiates the `rv32i_top` module, provides a clock and reset, and monitors the processor's state.

### Assembly Programs
We verified the processor using three assembly programs (located in `programs/`):
1. **Arithmetic Test**: Verifies R-type and I-type arithmetic operations.
2. **Loop/Control Test**: Verifies branching (`BNE`) and jumping logic.
3. **Memory Test**: Verifies `LW` and `SW` operations.

### How to Run Simulation
1. **Vivado**: Create a new project, add all files from `RTL_Design/` and `TB/top_tb.v`, then run Behavioral Simulation.
2. **ModelSim**: Use the provided script in `sim/run.do`:
   ```bash
   vsim -do sim/run.do
   ```

## 📂 Project Structure
- `RTL_Design/`: Verilog source files for the processor.
- `TB/`: Testbench files for unit and system-level testing.
- `programs/`: Assembly source code and corresponding Hex files.
- `sim/`: Simulation scripts.
- `docs/`: Technical report and schematic diagrams.

---
**Team Members:** Mohammed Saeed, Mohammed Awad-Allah, Mario Mody, Sagda Hossameldin, Haroun Taha.
