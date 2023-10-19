// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2020.2 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XKRNL_AXI_H
#define XKRNL_AXI_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xkrnl_axi_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u32 Control_BaseAddress;
} XKrnl_axi_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XKrnl_axi;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XKrnl_axi_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XKrnl_axi_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XKrnl_axi_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XKrnl_axi_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XKrnl_axi_Initialize(XKrnl_axi *InstancePtr, u16 DeviceId);
XKrnl_axi_Config* XKrnl_axi_LookupConfig(u16 DeviceId);
int XKrnl_axi_CfgInitialize(XKrnl_axi *InstancePtr, XKrnl_axi_Config *ConfigPtr);
#else
int XKrnl_axi_Initialize(XKrnl_axi *InstancePtr, const char* InstanceName);
int XKrnl_axi_Release(XKrnl_axi *InstancePtr);
#endif

void XKrnl_axi_Start(XKrnl_axi *InstancePtr);
u32 XKrnl_axi_IsDone(XKrnl_axi *InstancePtr);
u32 XKrnl_axi_IsIdle(XKrnl_axi *InstancePtr);
u32 XKrnl_axi_IsReady(XKrnl_axi *InstancePtr);
void XKrnl_axi_Continue(XKrnl_axi *InstancePtr);
void XKrnl_axi_EnableAutoRestart(XKrnl_axi *InstancePtr);
void XKrnl_axi_DisableAutoRestart(XKrnl_axi *InstancePtr);

void XKrnl_axi_Set_hbm(XKrnl_axi *InstancePtr, u64 Data);
u64 XKrnl_axi_Get_hbm(XKrnl_axi *InstancePtr);
void XKrnl_axi_Set_size(XKrnl_axi *InstancePtr, u32 Data);
u32 XKrnl_axi_Get_size(XKrnl_axi *InstancePtr);
void XKrnl_axi_Set_write_r(XKrnl_axi *InstancePtr, u32 Data);
u32 XKrnl_axi_Get_write_r(XKrnl_axi *InstancePtr);

void XKrnl_axi_InterruptGlobalEnable(XKrnl_axi *InstancePtr);
void XKrnl_axi_InterruptGlobalDisable(XKrnl_axi *InstancePtr);
void XKrnl_axi_InterruptEnable(XKrnl_axi *InstancePtr, u32 Mask);
void XKrnl_axi_InterruptDisable(XKrnl_axi *InstancePtr, u32 Mask);
void XKrnl_axi_InterruptClear(XKrnl_axi *InstancePtr, u32 Mask);
u32 XKrnl_axi_InterruptGetEnabled(XKrnl_axi *InstancePtr);
u32 XKrnl_axi_InterruptGetStatus(XKrnl_axi *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
