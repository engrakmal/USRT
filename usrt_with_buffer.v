module usrt_with_buffer(CLOCK, RESET, SEND, LOAD, READ, Tx_Data_In, Rx_Data_Out, NINTO, NINTI);
input CLOCK, RESET, SEND, LOAD, READ;
input [7:0] Tx_Data_In;
output NINTO, NINTI;
output [7:0] Rx_Data_Out;
wire [7:0] Tx_Data_Out, Rx_Data_In;

buffer_tx inst_buffer_tx(CLOCK, RESET, LOAD, Tx_Data_In, Tx_Data_Out);
usrt_without_buffer inst_usrt_without_buffer(CLOCK, RESET, SEND, Tx_Data_Out, Rx_Data_In, NINTO, NINTI);
buffer_rx inst_buffer_rx(CLOCK, RESET, READ, Rx_Data_In, Rx_Data_Out);

endmodule