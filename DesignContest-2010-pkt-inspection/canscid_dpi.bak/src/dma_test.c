/***************************** Include Files ********************************/
#include "dma_test.h"
#include "my_timer.h"
#include "kraaken_dpi.h"
#include "example_fifo_loopback_vhdl.h"

typedef struct {
  XDmaCentral * DmaPtr ;
  u32 * Status ;
  u32 * SrcPtr ;
  u32 * DestPtr ;
  u32 size ;

} XDmaIntrArgs ;

void check_dma_data ( u32 size, u32 * SrcPtr, u32 * DestPtr ) {

  u32 Index ;
  u32 fail = 0;
  double dma_transfer_time; 

  //Interrupt when dma transfer is done
  //Seems to hang here
  
  /*
  printf( "check_dma_data::\r\n");
  for (Index = 0; Index < size; Index++) {
    if (DestPtr[Index] != SrcPtr[Index]) {
      printf( "check_dma_data::Src[%d] (%d) != Dest (%d)\r\n",
	      Index,SrcPtr[Index],DestPtr[Index]);
      fail =1 ;
      break ;
    }
  }
  */

  if ( fail ) 
    printf ("check_dma_data::FAIL\r\n");
  else
    printf ("check_dma_data::PASS\r\n");
}

//----------------------------------------------------
// INTERRUPT HANDLER FUNCTION
//----------------------------------------------------
void dma_Intr_Handler(void * arg_ptr )
{

  endTiming();
  double dma_transfer_time = getProcessingTime();
  printf("Total processing time: %lf seconds\r\n", dma_transfer_time);

  Xuint32 IpStatus;

  XDmaIntrArgs * ArgPtr = (XDmaIntrArgs *)arg_ptr ;

  XDmaCentral * InstancePtr = ArgPtr->DmaPtr ;

  IpStatus = XDmaCentral_InterruptStatusGet(InstancePtr);

  Xuint32 Kraaken_Dpi_Baseaddr = XPAR_KRAAKEN_DPI_0_BASEADDR ;
  Xuint32 Reg_Read_Data;

  Reg_Read_Data = KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG0_OFFSET);
  printf("dma_intr_handler::Kraaken_PktCnt = %d\r\n",Reg_Read_Data);

  Reg_Read_Data = KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG1_OFFSET);
  printf("dma_intr_handler::Kraaken_Accum = %d\r\n",Reg_Read_Data);

  Reg_Read_Data = KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG2_OFFSET);
  printf("dma_intr_handler::Kraaken_slvreg2 = %d\r\n",Reg_Read_Data);

  //DMA done
  if (IpStatus & XDMC_IXR_DMA_DONE_MASK ){
    printf("dma_intr_handler::DMA DONE\r\n");
    *(ArgPtr->Status)=1 ;

    check_dma_data( ArgPtr->size, ArgPtr->SrcPtr, ArgPtr->DestPtr );

  }

  if (IpStatus & XDMC_IXR_DMA_ERROR_MASK ){
    printf("dma_intr_handler::DMA ERROR\r\n");
    *(ArgPtr->Status)=1 ;
  }

  XDmaCentral_InterruptClear(InstancePtr, XDMC_IXR_DMA_DONE_MASK);
  printf("dma_intr_handler::DONE\r\n");

}

int dma_test(XDmaCentral * InstancePtr, u32 * SrcPtr, u32 * DestPtr, u32 size )
{
	u32 Index;
	u32 RegValue;
	u32 IntStatus = 0;
	u32 DmaTransferSizeInBytes ;
	Xuint32 Kraaken_Dpi_Baseaddr = XPAR_KRAAKEN_DPI_0_BASEADDR ;
	//Xuint32 Kraaken_Dpi_Baseaddr = XPAR_EXAMPLE_FIFO_LOOPBACK_VHDL_0_BASEADDR ;

	//DmaTransferSizeInBytes = size * 4 ;
	//Hanging, so send in less than wfifo size
	size = 100000;
	DmaTransferSizeInBytes = size * 4 ;


	/*
	 * Assert the argument
	 */
	XASSERT_NONVOID(InstancePtr != NULL);
	XASSERT_NONVOID(InstancePtr->IsReady == XCOMPONENT_IS_READY);

	XDmaIntrArgs * IntrArgs = (XDmaIntrArgs *)malloc(sizeof(XDmaIntrArgs));
	IntrArgs->DmaPtr = InstancePtr ;
	IntrArgs->Status = &IntStatus ;
	IntrArgs->SrcPtr = SrcPtr;
	IntrArgs->DestPtr = DestPtr;
	IntrArgs->size = size;

	//----------------------------------------------------
	// REGISTER INTERRUPT HANDLER
	//----------------------------------------------------
	printf("  - Registering interrupt handler\r\n");
	XIntc_RegisterHandler(XPAR_XPS_INTC_0_BASEADDR,
			      XPAR_XPS_INTC_0_XPS_CENTRAL_DMA_0_IP2INTC_IRPT_INTR,
			      dma_Intr_Handler,
			      (void *)IntrArgs) ;
	//----------------------------------------------------

	//----------------------------------------------------
	// ENABLE INTERRUPTS
	//----------------------------------------------------
	printf("  - Enabling interrupts\r\n");

	// Enable INTC interrupts
	XIntc_mMasterEnable(XPAR_XPS_INTC_0_BASEADDR);
	XIntc_mEnableIntr(XPAR_XPS_INTC_0_BASEADDR,
			  XPAR_XPS_CENTRAL_DMA_0_IP2INTC_IRPT_MASK);

	// Enable Microblaze interrupts
	microblaze_enable_interrupts();
	//----------------------------------------------------

	printf( "initialize dma_data::Size=%d\r\n",size);  
	/*
	 * Initialize the source buffer bytes with a pattern and the
	 * the destination buffer bytes to zero.
	 */
 	for (Index = 0; Index < size; Index++) {
 		SrcPtr[Index] = Index;
 		DestPtr[Index] = 0;
 	}
	printf( "initialize dma_data::DONE\r\n");  

	/*
	 * Reset the device to get it back to its default state
	 */
	XDmaCentral_Reset(InstancePtr);

	// Enable dma interrupts
	XDmaCentral_InterruptEnableSet(InstancePtr, 
				       XDMC_IXR_DMA_DONE_MASK | XDMC_IXR_DMA_ERROR_MASK );


	/* Setup the DMA Control register to be:
	 *	- Source address incrementing
	 *	- Destination address incrementing
	 */
	//To increment src and destination as in DDR to DDR transfes
	/*
	  XDmaCentral_SetControl(InstancePtr,
				XDMC_DMACR_SOURCE_INCR_MASK |
				XDMC_DMACR_DEST_INCR_MASK);
	*/

	//To only incement src , as in DDR to PLB SLAVE FIFO transfer
	XDmaCentral_SetControl(InstancePtr,
			       XDMC_DMACR_SOURCE_INCR_MASK );

	/*
	 * Flush the Data Cache in the case the Data Cache is enabled.
	 */
	//XCACHE_FLUSH_DCACHE_RANGE(&SrcBuffer,  size);
	//XCACHE_FLUSH_DCACHE_RANGE(&DestBuffer, size);

	//Set Number of dataword to accumulate
	KRAAKEN_DPI_mWriteReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG0_OFFSET, size);

	Xuint32 Reg_Read_Data;

	/*
	 * Start the DMA transfer.
	 */
	//The size is in bytes, it is size*4
	DestPtr = (u32 *)(XPAR_KRAAKEN_DPI_0_BASEADDR+KRAAKEN_DPI_WRFIFO_DATA_OFFSET );
	//DestPtr = (u32 *)(XPAR_EXAMPLE_FIFO_LOOPBACK_VHDL_0_BASEADDR + EXAMPLE_FIFO_LOOPBACK_VHDL_WRFIFO_DATA_OFFSET );
	printf("Start DMA transfer\r\n");
	startTiming();
	
	XDmaCentral_Transfer(InstancePtr, (void *) SrcPtr,
		     (void *) DestPtr, DmaTransferSizeInBytes);

	/*
	for (Index = 0; Index < 1000; Index++) 
	  KRAAKEN_DPI_mWriteToFIFO(Kraaken_Dpi_Baseaddr,0, Index );

  Reg_Read_Data = KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG0_OFFSET);
  printf("dma_intr_handler::Kraaken_PktCnt = %d\r\n",Reg_Read_Data);

  Reg_Read_Data = KRAAKEN_DPI_mReadReg(Kraaken_Dpi_Baseaddr, KRAAKEN_DPI_SLV_REG1_OFFSET);
  printf("dma_intr_handler::Kraaken_Accum = %d\r\n",Reg_Read_Data);
	*/


	/*
	 * Wait until the DMA transfer is done
	 */

	// Poll DMA status register
// 	do {
// 	  RegValue = XDmaCentral_GetStatus(InstancePtr);
// 	}
// 	while ((RegValue & XDMC_DMASR_BUSY_MASK) == XDMC_DMASR_BUSY_MASK);
	
	//Interrupt loop
	u32 cnt = 0;
	
	while(1) {
	  if (IntStatus) break ;
	  //cnt++;
	  //printf("IntStatus = %d, cnt=%d\r\n",IntStatus,cnt);
	} ;

	/*
	 * If Bus error occurs, reset the device and return the error code.
	 */
// 	if (RegValue & XDMC_DMASR_BUS_ERROR_MASK) {
// 		XDmaCentral_Reset(InstancePtr);
// 		return XST_FAILURE;
// 	}

	/*
	 * DMA transfer is completely successful, check the destination buffer.
	 */
// 	for (Index = 0; Index < size; Index++) {
// 		if (DestPtr[Index] != SrcPtr[Index]) {
// 			/*
// 			 * Destination buffer's contents are different from the
// 			 * source buffer. Reset the device again and return
// 			 * error code.
// 			 */
// 			XDmaCentral_Reset(InstancePtr);
// 			return XST_FAILURE;
// 		}
// 	}

	/*
	 * Destination buffer's contents are the same as the source buffer
	 * Reset the device again and return success code.
	 */
	XDmaCentral_Reset(InstancePtr);

	return XST_SUCCESS;
}


