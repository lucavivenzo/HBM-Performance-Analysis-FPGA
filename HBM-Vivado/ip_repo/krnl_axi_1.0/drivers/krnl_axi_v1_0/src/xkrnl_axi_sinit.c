// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xkrnl_axi.h"

extern XKrnl_axi_Config XKrnl_axi_ConfigTable[];

XKrnl_axi_Config *XKrnl_axi_LookupConfig(u16 DeviceId) {
	XKrnl_axi_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XKRNL_AXI_NUM_INSTANCES; Index++) {
		if (XKrnl_axi_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XKrnl_axi_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XKrnl_axi_Initialize(XKrnl_axi *InstancePtr, u16 DeviceId) {
	XKrnl_axi_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XKrnl_axi_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XKrnl_axi_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

