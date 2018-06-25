module memory(clk,reset,address,data_in,data_out,rwn,start);
	parameter memory_size = 16;
	parameter word_size = 32;

	input clk, reset, start, rwn;
	input [memory_size-1:0] address;
	input [word_size-1:0] data_in;
	output reg [word_size-1:0] data_out;

	reg [word_size-1:0] array[0:(2**memory_size)-1];
	integer i;


	always @(posedge clk or reset)
	begin
		if(~reset) begin
			for(i=0; i<(2**memory_size); i=i+1) begin
				array[i] <= 32'h00000000;
			end
		end
		else if(start) begin
			if(rwn)
				data_out = array[address[11:0]];
			else begin
				array[address[11:0]] <= data_in[31:0];
			end
		end
	end
endmodule
