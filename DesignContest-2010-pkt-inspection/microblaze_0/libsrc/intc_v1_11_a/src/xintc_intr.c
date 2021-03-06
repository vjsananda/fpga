/* $Id: xintc_intr.c,v 1.1.2.1 2008/02/12 13:58:05 svemula Exp $ */
/******************************************************************************
*
*       XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"
*       AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND
*       SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,
*       OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,
*       APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION
*       THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,
*       AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE
*       FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY
*       WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE
*       IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR
*       REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF
*       INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
*       FOR A PARTICULAR PURPOSE.
*
*       (c) Copyright 2002-2007 Xilinx Inc.
*       All rights reserved.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file xintc_intr.c
*
* This file contains the interrupt processing for the XIntc component which
* is the driver for the Xilinx Interrupt Controller.  The interrupt
* processing is partitioned seperately such that users are not required to
* use the provided interrupt processing.  This file requires other files of
* the driver to be linked in also.
*
* Two different interrupt handlers are provided for this driver such that the
* user must select the appropriate handler for the application.  The first
* interrupt handler, XIntc_VoidInterruptHandler, is provided for systems
* which use only a single interrupt controller or for systems that cannot
* otherwise provide an argument to the XIntc interrupt handler (e.g., the RTOS
* interrupt vector handler may not provide such a facility).  The constant
* XPAR_INTC_SINGLE_DEVICE_ID must be defined for this handler to be included in
* the driver.  The second interrupt handler, XIntc_InterruptHandler, uses an
* input argument which is an instance pointer to an interrupt controller driver
* such that multiple interrupt controllers can be supported.  This handler
* requires the calling function to pass it the appropriate argument, so another
* level of indirection may be required.
*
* Note that both of these handlers are now only provided for backward
* compatibility. The handler defined in xintc_l.c is the recommended handler.
*
* The interrupt processing may be used by connecting one of the interrupt
* handlers to the interrupt system.  These handlers do not save and restore
* the processor context but only handle the processing of the Interrupt
* Controller.  The two handlers are provided as working examples. The user is
* encouraged to supply their own interrupt handler when performance tuning is
* deemed necessary.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who  Date     Changes
* ----- ---- -------- ---------------------------------------------------------
* 1.00b jhl  02/13/02 First release
* 1.00c rpm  10/17/03 New release. Support the static vector table created
*                     in the xintc_g.c configuration table. Collapse handlers
*                     to use the XIntc_DeviceInterruptHandler() in xintc_l.c.
* 1.00c rpm  04/09/04 Added conditional compilation around the old handler
*                     XIntc_VoidInterruptHandler(). This handler will only be
*                     include/compiled if XPAR_INTC_SINGLE_DEVICE_ID is defined.
* 1.10c mta  03/21/07 Updated to new coding style
* </pre>
*
* @internal
*
* This driver assumes that the context of the processor has been saved prior to
* the calling of the Interrupt Controller interrupt handler and then restored
* after the handler returns. This requires either the running RTOS to save the
* state of the machine or that a wrapper be used as the destination of the
* interrupt vector to save the state of the processor and restore the state
* after the interrupt handler returns.
*
******************************************************************************/

/***************************** Include Files *********************************/

#include "xbasic_types.h"
#include "xparameters.h"
#include "xintc.h"

/************************** Constant Definitions *****************************/



/**************************** Type Definitions *******************************/


/***************** Macros (Inline Functions) Definitions *********************/


/************************** Function Prototypes ******************************/


/************************** Variable Definitions *****************************/


/*****************************************************************************/
/**
*
* Interrupt handler for the driver used when there can be no argument passed
* to the handler.  This function is provided mostly for backward compatibility.
* The user should use XIntc_DeviceInterruptHandler(), defined in xintc_l.c,
* if possible.
*
* The user must connect this function to the interrupt system such that it is
* called whenever the devices which are connected to it cause an interrupt.
*
* @return	None.
*
* @note
*
* The constant XPAR_INTC_SINGLE_DEVICE_ID must be defined for this handler
* to be included in the driver compilation.
*
******************************************************************************/
#ifdef XPAR_INTC_SINGLE_DEVICE_ID
void XIntc_VoidInterruptHandler()
{
	/* Use the single instance to call the main interrupt handler */
	XIntc_DeviceInterruptHandler((void *) XPAR_INTC_SINGLE_DEVICE_ID);
}
#endif

/*****************************************************************************/
/**
*
* The interrupt handler for the driver. This function is provided mostly for
* backward compatibility.  The user should use XIntc_DeviceInterruptHandler(),
* defined in xintc_l.c when possible and pass the device ID of the interrupt
* controller device as its argument.
*
* The user must connect this function to the interrupt system such that it is
* called whenever the devices which are connected to it cause an interrupt.
*
* @param	InstancePtr is a pointer to the XIntc instance to be worked on.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
void XIntc_InterruptHandler(XIntc * InstancePtr)
{
	/* Assert that the pointer to the instance is valid
	 */
	XASSERT_VOID(InstancePtr != NULL);

	/* Use the instance's device ID to call the main interrupt handler.
	 * (the casts are to avoid a compiler warning)
	 */
	XIntc_DeviceInterruptHandler((void *)
				     ((u32) (InstancePtr->CfgPtr->DeviceId)));
}
