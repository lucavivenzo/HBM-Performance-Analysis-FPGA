// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xkrnl_axi.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XKrnl_axi_CfgInitialize(XKrnl_axi *InstancePtr, XKrnl_axi_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XKrnl_axi_Start(XKrnl_axi *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL) & 0x80;
    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XKrnl_axi_IsDone(XKrnl_axi *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XKrnl_axi_IsIdle(XKrnl_axi *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XKrnl_axi_IsReady(XKrnl_axi *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XKrnl_axi_Continue(XKrnl_axi *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL) & 0x80;
    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL, Data | 0x10);
}

void XKrnl_axi_EnableAutoRestart(XKrnl_axi *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XKrnl_axi_DisableAutoRestart(XKrnl_axi *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_AP_CTRL, 0);
}

void XKrnl_axi_Set_hbm(XKrnl_axi *InstancePtr, u64 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_HBM_DATA, (u32)(Data));
    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_HBM_DATA + 4, (u32)(Data >> 32));
}

u64 XKrnl_axi_Get_hbm(XKrnl_axi *InstancePtr) {
    u64 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_HBM_DATA);
    Data += (u64)XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_HBM_DATA + 4) << 32;
    return Data;
}

void XKrnl_axi_Set_size(XKrnl_axi *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_SIZE_DATA, Data);
}

u32 XKrnl_axi_Get_size(XKrnl_axi *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_SIZE_DATA);
    return Data;
}

void XKrnl_axi_Set_write_r(XKrnl_axi *InstancePtr, u32 Data) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_WRITE_R_DATA, Data);
}

u32 XKrnl_axi_Get_write_r(XKrnl_axi *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_WRITE_R_DATA);
    return Data;
}

void XKrnl_axi_InterruptGlobalEnable(XKrnl_axi *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_GIE, 1);
}

void XKrnl_axi_InterruptGlobalDisable(XKrnl_axi *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_GIE, 0);
}

void XKrnl_axi_InterruptEnable(XKrnl_axi *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_IER);
    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_IER, Register | Mask);
}

void XKrnl_axi_InterruptDisable(XKrnl_axi *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_IER);
    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_IER, Register & (~Mask));
}

void XKrnl_axi_InterruptClear(XKrnl_axi *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKrnl_axi_WriteReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_ISR, Mask);
}

u32 XKrnl_axi_InterruptGetEnabled(XKrnl_axi *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_IER);
}

u32 XKrnl_axi_InterruptGetStatus(XKrnl_axi *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKrnl_axi_ReadReg(InstancePtr->Control_BaseAddress, XKRNL_AXI_CONTROL_ADDR_ISR);
}

