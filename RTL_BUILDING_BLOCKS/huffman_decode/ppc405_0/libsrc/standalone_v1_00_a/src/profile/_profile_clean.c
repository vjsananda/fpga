//
// Copyright (c) 2002 Xilinx, Inc.  All rights reserved. 
// Xilinx, Inc. 
//
// XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A 
// COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS 
// ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR 
// STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION 
// IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE 
// FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION. 
// XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO 
// THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO 
// ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE 
// FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY 
// AND FITNESS FOR A PARTICULAR PURPOSE. 
//
// $Id: _profile_clean.c,v 1.1.4.1 2005/02/11 23:53:22 rajn Exp $
//

#include "profile.h"


/*
 * This function is the exit routine and is called by the crtinit, when the 
 * program terminates. The name needs to be changed later..
 */
void _profile_clean( void ) 
{
#ifdef PROC_MICROBLAZE
	// Disable the Interrupts
	asm("mfs r11, rmsr") ;
	asm("andi r11, r11, 0xfffffffd") ;
	asm("mts rmsr, r11") ;
#endif

}

