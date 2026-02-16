**# Week 9 Mini Project - Wrap Bit FIFO**



This project implements a wrap-bit FIFO architecture, focusing on pointer-based state tracking without using a count register.



-----------------------------------------------------------------------------

**## Files**



* fifo.v : RTL design of wrap-bit FIFO
* fifo\_tb.v : Randomized testbench for verification



-----------------------------------------------------------------------------

**## Objective** 



* Design a FIFO using wrap-bit pointer architecture.
* Eliminate FULL/EMPTY ambiguity without sacrificing memory.
* Avoid count-based implementation.
* Maintain symmetric read-write behavior.
* Apply clean RTL structure with clear state reasoning.



-----------------------------------------------------------------------------

**## FIFO Architecture Overview**



The FIFO consists of:

* **Memory Array** -> Stores data entries
* **Write Pointer** -> Tracks write position
* **Read Pointer** -> Tracks read position
* **Wrap Bit** -> Tracks circular overflow
* **State Logic** -> Determines FULL and EMPTY conditions



Each pointer is structured as:

\[wrap\_bit | address\_bits]

* DEPTH = 8
* Address bits = 3
* Wrap bit = 1
* Total pointer width = 4



------------------------------------------------------------------------------

**## State Detection Logic**



* EMPTY Condition: Both address and wrap bits are equal
* FULL Condition: Address bits are equal and wrap bits are different
* Symmetric FULL Handling: Allows simultaneous read and write when FIFO is FULL



------------------------------------------------------------------------------

**## Learning Outcomes**



* Understood circular buffer behavior in hardware
* Learned the purpose of pointer width including the extra wrap bit
* Resolved FULL/EMPTY ambiguity using wrap-bit logic
* Improved throughput using symmetric FULL handling
* Strengthened architectural reasoning in RTL design



-------------------------------------------------------------------------------

**# Author:** MARK JUSTIN

