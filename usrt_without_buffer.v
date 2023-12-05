module usrt_without_buffer(CLOCK, RESET, SEND, Tx_Data, Rx_Data, NINTO, NINTI);
input CLOCK, RESET, SEND;
input [7:0] Tx_Data;
output [7:0] Rx_Data;
output NINTO, NINTI;

wire SO;

usrt_tx inst_usrt_tx(CLOCK, RESET, SEND, Tx_Data, NINTO, SO);
usrt_rx inst_usrt_rx(CLOCK, RESET, SO, NINTI, Rx_Data);

endmodule