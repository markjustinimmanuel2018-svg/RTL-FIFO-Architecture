**# Week 10 Mini Project - Self Checking FIFO Verification**



This project upgrades the FIFO verification approach from manual testbench inspection to a fully self-checking testbench with an independent reference model.



----------------------------------------------------------------

**## Files**



* tb\_fifo.v : Self-checking testbench with scoreboard



----------------------------------------------------------------

**## Objective**



* Move from manual verification to automated verification
* Build an independent reference model (scoreboard)
* Detect data mismatches automatically
* Verify FULL and EMPTY flags bidirectionally
* Detect unknown propagation



----------------------------------------------------------------

**## Verification Architecture Overview**



The verification environment consists of:

* **Stimulus Generator** - Random write/read enable signals
* **Reference Model** - Linear behavioral FIFO model
* **Scoreboard Logic** - Compares DUT output with expected data
* **Flag Checker** - Validates FULL and EMPTY correctness
* **Pass/Fail Logic** - Reports final result automatically

The model is intentionally independent of DUT internals.



----------------------------------------------------------------

**## Testbench Flow**



* Reference Model Design
  - Write Condition
  - Read Condition
* Timing Alignment
* Error Detection Mechanisms
  - Data Mismatch Detection
  - X-State Detection
  - FULL/EMPTY Flag Verification



----------------------------------------------------------------

**## Learning Outcomes**



* Understood the difference between design and verification flow
* Built an independent behavioral reference model
* Learned proper scoreboard alignment with synchronous logic
* Implemented bidirectional flag checking
* Transitioned from manual checking to automated verification



----------------------------------------------------------------
**# Author:** MARK JUSTIN

