module buffer_tx(CLOCK, RESET, LOAD, Tx_Data_In, Tx_Data_Out);
input CLOCK, RESET, LOAD;
input [7:0] Tx_Data_In;
output [7:0] Tx_Data_Out;

reg [7:0] buffer;
	
always @(posedge CLOCK)
	begin
		if (RESET)
			buffer = 8'h00;
		else if (LOAD)
			buffer = Tx_Data_In;
		else
			buffer = buffer;
	end

assign 	Tx_Data_Out = buffer;	
endmodule