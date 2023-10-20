# Vitis Flow - HBM Performance Analysis on FPGA

## Overview

This section of the repository is dedicated to the Vitis flow used in the MSc thesis project "Performance Analysis of HBM Memory on Reconfigurable Devices Using Different Design Flows." The design in this flow leverages the Vitis Application Acceleration Development framework to analyze High Bandwidth Memory (HBM) performance on the Xilinx Alveo U280 FPGA.
In the Vitis flow using Vivado and Vitis 2020.2, the application was developed using the Vitis Application Acceleration Development framework. This approach simplifies development and accelerates the design process for FPGA-based applications.

## Folder Structure

- **common**: The "common" folder contains essential files for the OpenCL library, the xcl2 files, and various utilities. These files are integral for compiling and running the application within the Vitis environment.

- **scripts**: The "scripts" directory includes shell scripts that help set environment variables, build the application, and launch it on the FPGA.

- **src**: In the "src" folder, you'll find the source code for the application:
  - **host.cpp**: This code serves as the host program, orchestrating the execution on the FPGA.
  - **krnl_axi.cpp**: This file is used to generate the krnl_axi IP using HLS.

  Additional host files are provided and can be used to test the HBM in various access patterns.

- **alveou280.ini**: This configuration file specifies FPGA-specific settings and configurations.

- **makefile**: The makefile simplifies the compilation and build process for the application.

## Design Overview

### Kernel

The IP is created using High-Level Synthesis (HLS) and can be controlled through an AXI Lite Slave interface to define transaction parameters and initiate them. To maximize High Bandwidth Memory (HBM) performance, burst transactions are essential.

To ensure Vitis HLS recognizes burst transfers, the "Manual Burst" functionality through the hls::burst_maxi class was used.  
The hls::burst_maxi class provides explicit methods for burst transactions, including read and write requests, data transfers, and response handling.

The kernel has three key parameters:

- hls::burst_maxi<ap_uint<512>>: Represents the interface with the HBM, utilizing an unsigned integer of 512 bits to align with the 512-bit AXI data width of the kernel.
- const unsigned int size: Specifies the size of transfers to initiate, expressed in terms of transfers of 512 bits.
- bool write: Determines whether to initiate a write or read request.

Pragmas are used to specify the interface type for these parameters. The write and size parameters are designated as AXI Lite Slave interfaces. By designating the same interface for the return parameter, control commands are passed using the AXI interface as well. For the HBM port, the master AXI interface is specified, as it connects to the HBM memory. By setting offset=slave, an address offset port is generated to specify the transaction address and is mapped to the same AXI Lite Slave interface.

The code for transaction initiation is straightforward. Depending on the value of the write bit, either a read or write transaction is initiated using the hls::burst_maxi methods within a for loop.

### Host Program

Certainly! Here's a summarized version of the text to be added to the "Host Program" section of the README:

### Host Program

The Host program utilizes the OpenCL API to launch and manage kernel runs on the FPGA. The process involves several steps:

1. **Context Creation**: Create a Context instance, which includes the OpenCL device connected to the host system.

2. **Command Queue**: Create a CommandQueue instance responsible for scheduling the execution of kernels on the devices included in the Context. Ensure to specify `CL_QUEUE_PROFILING_ENABLE` to track kernel execution time and `CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE` to run multiple kernels in parallel.

3. **OpenCL Program**: Create an OpenCL Program object, comprising a set of kernels specified in the binary file of the FPGA implementation.

4. **Kernel Initialization**: Initialize data structures for the kernels.

5. **Transaction Size and Buffer Allocation**: Choose the size of the transaction and allocate buffers to different banks of the High Bandwidth Memory (HBM). This determines where the transaction will occur.

6. **Setting Kernel Arguments**: Set the arguments of the kernel, including size and write flags.

7. **Kernel Execution**: Start the kernels, and retrieve profiling data to obtain the execution time of the kernels. This data allows for performance analysis and optimization.

### Configuration File

Certainly! Here's a summarized version of the text to be added to the "Configuration File" section of the README:

### Configuration File

The Configuration File specifies various settings for the implementation design of the application:

- **nk Parameter**: Determines the number of instances of a kernel to be synthesized on the board. In this case, 32 instances were chosen.

- **slr Parameter**: Specifies the Super Logic Region (SLR) on which each kernel will be synthesized. In this project, all kernels are synthesized on SLR=0.

- **sp Parameter**: Maps the kernel ports to specific memory resources. In this project, all kernels are assigned to all High Bandwidth Memory (HBM) ports to enable each kernel to access the entire HBM memory. The `gmem0` bundle is is the bundle we specified for the interface of the Kernel code.

## Installation and Execution

To set up and run the application in the Vitis flow (Vivado and Vitis 2020.2):

1. **Clone the Repository**: Clone this repository to your local machine using the following command:

   ```shell
   git clone https://github.com/lucavivenzo/HBM-Performance-Analysis-FPGA
   ```

2. **Launch Build Script**:

   - Navigate to the "HBM-Vitis" folder within the cloned repository.
   - Execute the `launchBuild.sh` script.

3. **Launch the Application**:

   - After the build process is complete, you can launch the application on the FPGA by executing the `launchProgram.sh` script.

4. If you need to modify the host program after the building process you can recompile it by launching:

   ```shell
   make host
   ```

### Usage

With the application installed and running, you can use the provided host code and FPGA bitstreams to analyze HBM performance in various access patterns. Modify the host code as needed to conduct different tests.
