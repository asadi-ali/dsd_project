module memory(clk, reset, address_dec, address_test, data_in, data_out, rwn, start);
	parameter memory_size = 16;
	parameter word_size = 32;

	input clk, reset, start, rwn;
	input [memory_size-1:0] address_dec, address_test;
	input [word_size-1:0] data_in;
	output reg [word_size-1:0] data_out;

	reg [word_size-1:0] array[0:199];
	integer i;

	always @(posedge clk)
	begin
		if(~reset) begin
			for(i=0; i<200; i=i+1) begin
				array[i] <= 32'h00000000;
			end
		end
		else if (rwn)
			data_out = array[address_test];
		else if (start)
			array[address_dec] <= data_in[31:0];
	end
endmodule
