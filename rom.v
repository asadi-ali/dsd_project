module rom(address,data);
input [7:0] address;
output [7:0] data;
reg [7:0] array[255:0];
always @* begin
	array[8'h00] = 8'h00;
	array[8'h01] = 8'h11;
	array[8'h02] = 8'h22;
	array[8'h03] = 8'h33;
	array[8'h04] = 8'h44;
	array[8'h05] = 8'h55;
	array[8'h06] = 8'h66;
	array[8'h07] = 8'h77;
	array[8'h08] = 8'h88;
	array[8'h09] = 8'h99;
end
assign data=array[address];
endmodule 
