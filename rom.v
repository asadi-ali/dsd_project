module rom(address,data);
input [7:0] address;
output reg[7:0] data;
always @*
	case (address)
		8'b00000000: data = 8'b01101111; 
		8'b00000001: data = 8'b00011000;
		default: data = 8'b00000000;
	endcase
endmodule