**# Week 12 Mini Project - Data Transfer Controller**



This project implements a FSM-based data controller that interacts with a FIFO and generates pulse-based control signals with latency awareness.



-----------------------------------------------------------------

**## Files**



* data\_transfer\_ctrl.v    : RTL design of data transfer controller
* tb\_data\_transfer\_ctrl.v : Self-checking testbench



-----------------------------------------------------------------

**## Objective**



* Design an FSM-based controller to manage FIFO data transfer
* Generate a single-cycle read enable pulse
* Capture FIFO output with correct latency alignment
* Generate single-cycle done pulse
* Verify pulse integrity and data correctness



-----------------------------------------------------------------

**## Architecture Overview**



The controller consists of:

* FSM (Control Unit)
  - IDLE
  - READ
  - PROCESS
  - DONE
* Control Signals
  - read\_en (1-cycle pulse)
  - busy (level signal)
  - done (1-cycle pulse)
* Datapath
  - Captures fifo\_dout during PROCESS state
  - Outputs stable data\_out



-------------------------------------------------------------------

**## Architecture Significance**



This module represents a small subsystem block that:

* Accepts request
* Interacts with external resource (FIFO)
* Processes data
* Signals completion



Bridges control logic and datapath reasoning



-------------------------------------------------------------------

**## Learning Outcomes**



* Designed synchronous FSM with clean state transitions
* Understood latency alignment between control and datapath
* Handled non-blocking assignment scheduling issues
* Learned clock-edge stimulus alignment in testbench
* Strengthened debugging skills in RTL verification



-------------------------------------------------------------------

**# Author:** MARK JUSTIN

