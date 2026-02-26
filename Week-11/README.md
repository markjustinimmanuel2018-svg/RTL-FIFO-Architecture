**# Week-11 Mini Project - Registered Priority Arbiter**



This project implements a 4-request fixed priority arbiter with registered output, focusing on control decision logic and timing-aware verification.



-------------------------------------------------------------------

**## Files**



* priority\_arbiter.v    : Registered fixed priority arbiter design
* tb\_priority\_arbiter.v : Self-checking testbench



-------------------------------------------------------------------

**## Objective**



* Design a fixed priority arbiter
* Ensure only one grant is active at a time
* Register output to avoid glitches
* Understand arbitration latency
* Align verification with registered timing



--------------------------------------------------------------------

**## Architecture Description**



The arbiter consists of:

* Combinational Logic
  - Resolves priority using casez pattern matching
* Sequential Logic
  - Registers the computed grant
  - Ensures glitch-free and stable control output
* Latency
  - Grant updates one clock cycle after request



Priority Rule: req\[3] > req\[2] > req\[1] > req\[0]

* Only the highest active request is granted



----------------------------------------------------------------------

**## Learning Outcomes**



* Priority-based arbitration
* Difference between combinational and registered control
* Glitch prevention using output registers
* Latency-aware verification alignment
* Functional vs structural correctness



-----------------------------------------------------------------------

**# Author:** MARK JUSTIN

