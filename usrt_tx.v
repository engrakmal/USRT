module usrt_tx(CLOCK, RESET, SEND, Tx_Data, NINTO, SO); 
input CLOCK, RESET;  
input SEND;
input [7:0] Tx_Data;  
output NINTO;
output SO;
//  s y m l b o l i c   s t a t e   d e c l a r a t i o n  
localparam [1:0] 
idle = 2'b00,  
start = 2'b01,  
data = 2'b10,  
stop = 2'b11;  

//  s i g n a l   d e c l a r a t i o n  
reg [1:0] state_reg;   
reg [2:0] n_reg;  
reg [7:0] b_reg;  
reg SO_reg; 
reg NINTO_TEMP;
	
//  FSMD  n e x t - s t a t e   l o g i c   &  f u n c t i o n a l   u n i t s  
always @(posedge CLOCK)  
begin 
/////////////////////// 
if (RESET)  
	begin  
		state_reg = idle;   
		n_reg = 0;  
		b_reg = 0;  
		SO_reg = 1'b1;
		NINTO_TEMP = 1'b0;  
	end 
else  
	begin  
	case (state_reg)  
		idle: 
			begin  
				SO_reg = 1'b1;
				NINTO_TEMP = 1'b0;   
				if (SEND)  
					begin  
						state_reg = start;    
						b_reg = Tx_Data;  
					end
			end 
		start: 
			begin  
				SO_reg = 1'b0;   
				state_reg = data;  
				n_reg = 0;
				NINTO_TEMP = 1'b1;  
			end 
		data:  
		
			begin  
				SO_reg = b_reg[0];
				b_reg = b_reg >> 1;  
				if (n_reg==7) 
					state_reg = stop;
				else  
					n_reg = n_reg + 1; 
			end 
		stop: 
			begin  
				SO_reg = 1'b1;  
				state_reg = idle;  
			end
		default:
			begin
			state_reg = idle;   
			n_reg = 0;  
			b_reg = 0;  
			SO_reg = 1'b1;
			NINTO_TEMP = 1'b0;
			end
	endcase  
	end
end 
//  o u t p u t  
assign SO = SO_reg;
assign NINTO = NINTO_TEMP;

endmodule