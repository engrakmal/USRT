module  usrt_rx (CLOCK, RESET, SI, NINTI, Rx_Data);
input CLOCK, RESET;  
input SI;
output NINTI;  
output [7:0] Rx_Data; 
// symbolic state declaration
localparam [1:0]
idle = 2'b00,  
start = 2'b01,  
data = 2'b10,  
stop = 2'b11;
  
// signal declaration
reg [1:0] state_reg; 
reg [3:0] n_reg; 
reg [7:0] b_reg;
reg NINTI_TEMP; 

// FSMD reg-state logic
always @(posedge CLOCK)
begin
//////////////////
if (RESET)
	begin
		state_reg = idle; 
		n_reg = 0;
		b_reg = 0;
		NINTI_TEMP = 1'b1;
	end
else
	begin 
	case (state_reg) 
		idle:
			begin
				if (~SI)
				state_reg = start;
			end
		start:
			begin
				state_reg = data;  
				n_reg = 0;
				NINTI_TEMP = 1'b0;
				b_reg = {SI, b_reg [7:1]};
			end
		data:
			begin
					if (n_reg == 7)
						begin
						state_reg = stop; 
						NINTI_TEMP = 1'b1;
						end
					else 
						begin
						b_reg = {SI, b_reg [7:1]}; 
						n_reg = n_reg + 1; 
						end
			end	
		stop:
			begin 
				state_reg = idle;
			end
		default:
			begin
				state_reg = idle; 
				n_reg = 0;
				b_reg = 0;
				NINTI_TEMP = 1'b1;
			end
	endcase   
	end 
end 
// output  
assign Rx_Data = b_reg;  
assign NINTI = NINTI_TEMP;
 
endmodule