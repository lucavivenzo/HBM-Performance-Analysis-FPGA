/*******************************************************************************
Description:
    This is a simple AXI Master which can read or write
Note:
	credo che venga creata quella struttura così da inviare sempre su tutto il bus
	AXI dell'HBM.
	v_dt è formato da 16 interi. Un intero è di 32 bit, quindi in totale sono 256 bit.
	Come ingresso della funzione c'è un vettore di v_dt.

*******************************************************************************/

#include "ap_int.h"
#include "hls_burst_maxi.h"

extern "C" {
void krnl_axi(
	hls::burst_maxi<ap_uint<512>> hbm,	// Interface with the HBM
	const unsigned int size,		// Size in trasfers (512 bit)
	bool write				// If 1 write operation, if 0 read
               ) {
#pragma HLS INTERFACE s_axilite port=return			//to control the IP via AXI
#pragma HLS INTERFACE m_axi port=hbm offset=slave bundle=gmem0	//offset=slave generates an address offset port and map it to the axi slave interface
#pragma HLS INTERFACE s_axilite port=size
#pragma HLS INTERFACE s_axilite port=write

	static ap_uint<512> temp1 = 1;
	static ap_uint<512> temp2;

	  if (write){
		  hbm.write_request(0,size);
		  axi1:
		  for (int i = 0; i < size; i++) {
			  hbm.write(temp1);
				}
		  hbm.write_response();
			}
	  else if(!write){
		  hbm.read_request(0,size);
		  axi2:
		  for (int i = 0; i < size; i++) {
			  temp2 = hbm.read();
		  }
	  }
	}
}
