#include "xcl2.hpp"
#include <algorithm>
#include <iostream>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <vector>

#define NUM_KERNELS 32

#define PC_NAME(n) n | XCL_MEM_TOPOLOGY
const int pc[32] = {
    PC_NAME(2),  PC_NAME(0),  PC_NAME(1),  PC_NAME(3),  PC_NAME(5),  PC_NAME(5),  PC_NAME(5),  PC_NAME(5),
    PC_NAME(5),  PC_NAME(5),  PC_NAME(5), PC_NAME(5), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21),
    PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21),
    PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21), PC_NAME(21)};


void allocate_copy_buffers(cl::Context &context, cl::CommandQueue &q, cl::Kernel &kernel, cl::Buffer *buffer_input, std::vector<int, aligned_allocator<int>> &source_hbm, int i, unsigned int size, bool write){
	
	std::cout << "allocating buffer " << i << "..." << std::endl;
	cl_int err;
	//For Allocating Buffer to specific Global Memory Bank, user has to use cl_mem_ext_ptr_t and provide the Banks
	cl_mem_ext_ptr_t inBufExt;

	inBufExt.obj = source_hbm.data();
	inBufExt.param = 0;
	inBufExt.flags = pc[i];

	//These commands will allocate memory on the FPGA. The cl::Buffer objects can be used to reference the memory locations on the device.
	
	//Creating Buffers
//	OCL_CHECK(err, buffer_input = new cl::Buffer(context, CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX | CL_MEM_USE_HOST_PTR, sizeof(uint32_t) * size, &inBufExt, &err));
	OCL_CHECK(err, buffer_input = new cl::Buffer(context, CL_MEM_WRITE_ONLY | CL_MEM_EXT_PTR_XILINX | CL_MEM_USE_HOST_PTR, sizeof(uint32_t) * size, &inBufExt, &err));
	//Setting the kernel Arguments
	OCL_CHECK(err, err = (kernel).setArg(0, *buffer_input));	//Interface with the HBM
	OCL_CHECK(err, err = (kernel).setArg(1, size/16));			//Size (for the kernel size 1 means 512 bits, in the code means 32 bits)
	OCL_CHECK(err, err = (kernel).setArg(2, write));			//To choose between read and write operation
	// Copy input data to Device Global Memory QUESTO SE NON FACCIAMO VERIFY DOVREBBE ESSERE INUTILE E POTREMMO METTERE CL_MEM_WRITE_ONLY
//	OCL_CHECK(err, err = q.enqueueMigrateMemObjects({*buffer_input}, 0 /* 0 means from host*/));
	q.finish();
}

void run_krnl(cl::CommandQueue &q, cl::Kernel &kernel, cl::Event &kernel_event){
	std::cout << "running kernel..." << std::endl;
	cl_int err;
	OCL_CHECK(err, err = q.enqueueNDRangeKernel(kernel, 0, 1, 1, NULL, &kernel_event));
}
//forse implementare il verify

int main(int argc, char *argv[]) {
	if (argc != 2) {
		printf("Usage: %s <XCLBIN> \n", argv[0]);
		return -1;
		}
	cl_int err;
	cl::Context context;
	cl::CommandQueue q;
	cl::Kernel kernel_axi[NUM_KERNELS];
	std::string binaryFile = argv[1];
	cl::Event kernel_events[NUM_KERNELS];
	cl_ulong tStart[NUM_KERNELS];
	cl_ulong tEnd[NUM_KERNELS];
	cl_ulong tDiff[NUM_KERNELS];
	cl::Buffer *buffer_input[NUM_KERNELS];
	
	std::cout << "Creating Context..." << std::endl;
	auto devices = xcl::get_xil_devices();
	auto device = devices[0];
	OCL_CHECK(err, context = cl::Context(device, NULL, NULL, NULL, &err));
	
	OCL_CHECK(err, q = cl::CommandQueue(context, device, CL_QUEUE_PROFILING_ENABLE | CL_QUEUE_OUT_OF_ORDER_EXEC_MODE_ENABLE, &err));
	
	std::string device_name = device.getInfo<CL_DEVICE_NAME>();
	auto fileBuf = xcl::read_binary_file(binaryFile);
	cl::Program::Binaries bins{{fileBuf.data(), fileBuf.size()}};
	devices.resize(1);
	OCL_CHECK(err, cl::Program program(context, devices, bins, NULL, &err));
	std::cout << "Device " << device_name.c_str() << ": program successful!" << std::endl;
	
	// kernels
	for (int kernel=0; kernel<NUM_KERNELS; kernel++) {
		char dummy[50];
		sprintf(dummy, "krnl_axi:{krnl_axi_%d}", kernel+1);
		OCL_CHECK(err, kernel_axi[kernel] = cl::Kernel(program, dummy, &err));
		std::cout << "Kernel sucessfully created" << std::endl ;
		}
	
	unsigned int dataSize = 1048576*64/32;//256 MB/32 per testare un solo banco
	
	if (xcl::is_emulation()) {
		dataSize = 1;
		std::cout << "Original Dataset is reduced for faster execution on emulation flow. Data size="<< dataSize << std::endl;
		}
		
	std::vector<int, aligned_allocator<int>> source_hbm(dataSize);
	// Create the test data (INUTILE senza verify)
	std::generate(source_hbm.begin(), source_hbm.end(), std::rand);
	
	double result = 0;
	double kernel_time_in_sec[NUM_KERNELS];
	
	if (!xcl::is_emulation()) {
		dataSize = 1048576*64/32;
		std::cout << "Picking Buffer size " << dataSize * sizeof(uint32_t) << std::endl;
		}
	
	for (int i=0; i<NUM_KERNELS; i++){
		allocate_copy_buffers(context, q, kernel_axi[i], buffer_input[i], source_hbm, i, dataSize, 1);
		}
	
	for (int i=0; i<NUM_KERNELS; i++){
		run_krnl(q, kernel_axi[i], kernel_events[i]);
		}
	
	q.finish();
	
	double GBsent;
	GBsent = dataSize * 4; //in Bytes
	GBsent /= (1000 * 1000 * 1000); // to GB
	
	for (int i =0; i<NUM_KERNELS; i++){
		kernel_events[i].getProfilingInfo(CL_PROFILING_COMMAND_START, &tStart[i]);
		kernel_events[i].getProfilingInfo(CL_PROFILING_COMMAND_END, &tEnd[i]);
		tDiff[i]=tEnd[i] - tStart[i];
		std::cout << "time of execution in ns of kernel " << i << " = " << tDiff[i] << std::endl;
		result = GBsent / tDiff[i]; 	//GB/ns
		result *= 1000000000;		//GB/s
		std::cout << "Bandwidth kernel " << i << " = " << result << " GB/s"  << std::endl;
		}
	
	return (EXIT_SUCCESS);
}
