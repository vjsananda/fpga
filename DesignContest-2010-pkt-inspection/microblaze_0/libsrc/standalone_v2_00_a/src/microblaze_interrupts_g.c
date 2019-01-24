
/*******************************************************************
*
* CAUTION: This file is automatically generated by libgen.
* Version: Xilinx EDK 10.1.03 EDK_K_SP3.6
* DO NOT EDIT.
*
* Copyright (c) 2005 Xilinx, Inc.  All rights reserved. 
* 
* Description: Interrupt Handler Table for MicroBlaze Processor
*
*******************************************************************/

#include "microblaze_interrupts_i.h"
#include "xparameters.h"


extern void XIntc_DeviceInterruptHandler (void *);

/*
* The interrupt handler table for microblaze processor
*/

MB_InterruptVectorTableEntry MB_InterruptVectorTable[] =
{
	XIntc_DeviceInterruptHandler,
	(void*) XPAR_XPS_INTC_0_DEVICE_ID
};

