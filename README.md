# CEP Processor Design and Programming

A joint educational project aimed at simulating a custom-designed CPU from scratch. This project bridges the gap between hardware and software by modeling both the architecture and its instruction execution logic.

Developed by: [elgouijf](https://github.com/elgouijf) and [elarabim](https://github.com/elarabim)

---

## 📌 Overview

CEP (Custom Educational Processor) is a minimal processor designed to teach fundamental concepts of:
- Digital logic and CPU architecture
- Instruction Set Architecture (ISA)
- Clock cycle-based simulation
- Low-level programming and control flow

The system is fully simulated in software to allow hands-on testing and debugging of custom programs without physical hardware.

---

## ✨ Features

- Custom-built instruction set (ISA)
- Register file, ALU, control unit, program counter, and memory simulation
- Instruction decoder and execution engine
- Support for branching, arithmetic operations, and more
- Assembly-like language interpreter for testing
- Clock-cycle based execution with step-by-step debugging
- Easy to extend with new opcodes

---

## 🧠 Architecture Breakdown

The CEP processor is composed of:

| Component        | Role                                                                 |
|------------------|----------------------------------------------------------------------|
| **Registers**     | General-purpose registers (R0-Rn) used for computation              |
| **ALU**           | Arithmetic Logic Unit handles all operations like ADD, SUB, AND     |
| **Control Unit**  | Decodes instructions and manages control signals                    |
| **Instruction Memory** | Stores the instruction stream                                 |
| **Data Memory**   | RAM-like storage accessible through load/store instructions         |
| **Program Counter**| Points to the current instruction                                  |
| **Clock System**  | Simulates sequential cycles                                         |

---

## 🗂️ File Structure

CEP-Processor-Design-and-Programming/
├── hardware/ # Hardware simulation: ALU, control unit, memory, etc.
├── decoder/ # Instruction decoding logic
├── simulator/ # Execution engine / core CPU simulation loop
├── programs/ # Sample programs written in CEP-Assembly
├── include/ # Header files and shared interfaces
├── tests/ # Unit tests and validation scripts
└── README.md # You're reading it!

## 🛠️ FPGA Simulation (Optional – Requires Vivado)

This project includes components that can be synthesized and simulated using Xilinx Vivado. To make full use of the vivado/ directory and testbenches, you should install:

    Vivado Design Suite WebPACK Edition or the full Vivado ML Edition, version 2024.2 or 2025.1.

        2024.2 is a stable, recent release.

        2025.1 is the latest available as of June 4, 2025.

✅ How to Obtain Vivado

    Visit the official AMD/Xilinx download portal and select the Vivado version you need—preferably 2024.2 or 2025.1
    AMD.

    Use the WebPACK installer (free, limited-device support) or the ML Edition installer for full device coverage.

    Choose your operating system (Windows or Linux) and download the Web Installer for an easier setup with needed device support
    AMD.

    Follow the installation guide (see “Download and Installation” in UG973 for Vivado 2020.2+)
    youtube.com+9docs.amd.com+9docs.amd.com+9.

After installation, you’ll be able to:

    Run VHDL/Verilog simulations for datapath and control units

    Launch testbenches located in the vivado/ directory

    Optionally generate bitstreams for FPGA implementation

## 🚀 Getting Started

### 1. Clone the repository

Run this in terminal:

git clone https://github.com/elgouijf/CEP-Processor-Design-and-Programming.git
cd CEP-Processor-Design-and-Programming

### 2. Read CEP_cdc.pdf

    📄 CEP_cdc.pdf (Project Specification Document) includes:

        A detailed breakdown on how to use the Makefile

        An overview of the processor’s design goals and modular structure

        A detailed breakdown of the instruction set architecture (ISA)

        Execution semantics and control unit behavior

        Memory layout and register conventions

        A dedicated section on how to use the Makefile to:

            Build the simulator

            Run custom .cep programs

            Launch test cases and simulations step-by-step

This document serves as the single source of truth for both contributors and users of the project. It is strongly recommended to read this file before interacting with the codebase or writing programs for the processor.

---

## Instruction Status

### Métadonnées

[![timestamp status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//timestamp.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//timestamp.svg)

Fichier de [log](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//log.txt)
### Arithmetiques

[![ADDI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//ADDI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//ADDI.svg)
[![ADD status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//ADD.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//ADD.svg)
[![SUB status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SUB.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SUB.svg)
### Basiques

[![REBOUCLAGE status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//REBOUCLAGE.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//REBOUCLAGE.svg)
[![LUI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LUI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LUI.svg)
### Divers

[![AUIPC status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//AUIPC.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//AUIPC.svg)
### Logiques

[![OR status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//OR.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//OR.svg)
[![ORI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//ORI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//ORI.svg)
[![AND status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//AND.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//AND.svg)
[![ANDI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//ANDI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//ANDI.svg)
[![XOR status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//XOR.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//XOR.svg)
[![XORI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//XORI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//XORI.svg)
### Décalages

[![SLL status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLL.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLL.svg)
[![SLLI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLLI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLLI.svg)
[![SRA status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SRA.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SRA.svg)
[![SRAI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SRAI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SRAI.svg)
[![SRL status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SRL.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SRL.svg)
[![SRLI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SRLI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SRLI.svg)
### Sets

[![SLT status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLT.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLT.svg)
[![SLTI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLTI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLTI.svg)
[![SLTIU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLTIU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLTIU.svg)
[![SLTU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLTU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SLTU.svg)
### Branchements

[![BEQ status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BEQ.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BEQ.svg)
[![BGE status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BGE.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BGE.svg)
[![BGEU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BGEU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BGEU.svg)
[![BLT status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BLT.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BLT.svg)
[![BLTU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BLTU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BLTU.svg)
[![BNE status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BNE.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//BNE.svg)
### Sauts

[![JAL status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//JAL.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//JAL.svg)
[![JALR status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//JALR.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//JALR.svg)
### Loads

[![LB status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LB.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LB.svg)
[![LBU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LBU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LBU.svg)
[![LH status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LH.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LH.svg)
[![LHU status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LHU.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LHU.svg)
[![LW status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LW.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//LW.svg)
### Stores

[![SB status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SB.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SB.svg)
[![SH status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SH.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SH.svg)
[![SW status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SW.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//SW.svg)
### Interruptions

[![CSRRC status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRC.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRC.svg)
[![CSRRCI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRCI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRCI.svg)
[![CSRRS status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRS.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRS.svg)
[![CSRRSI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRSI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRSI.svg)
[![CSRRW status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRW.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRW.svg)
[![CSRRWI status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRWI.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//CSRRWI.svg)
[![IT status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//IT.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/Eval/elarabim_elgouijf_eval//IT.svg)

## Travail evalué en présence des enseignants

[![compteur status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/compteur_elarabim_elgouijf.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/compteur_elarabim_elgouijf.svg)
[![chenillard_minimaliste status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/chenillard_minimaliste_elarabim_elgouijf.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/chenillard_minimaliste_elarabim_elgouijf.svg)
[![chenillard_rotation status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/chenillard_rotation_elarabim_elgouijf.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/chenillard_rotation_elarabim_elgouijf.svg)
[![invaders status](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/invaders_elarabim_elgouijf.svg)](https://CEP_Deploy.pages.ensimag.fr/CEP_Projet_G1_2024_2025/overview/manual/invaders_elarabim_elgouijf.svg)

