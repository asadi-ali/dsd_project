module decoderTB;

	parameter byte = 8;
	parameter width_in = 4 * byte;
	parameter width_out = 4 * byte;
	
	reg clk;
	reg reset;
	reg start;
	wire ready;
	reg [width_in - 1:0] instruction_in;
	wire [width_out - 1:0] instruction_out;
	wire start_for_memory;
	reg ready_for_memory;
	
	decoder TB(
		.clk(clk),
		.reset(reset),
		.start(start),
		.ready(ready),
		.instruction_in(instruction_in),
		.instruction_out(instruction_out),
		.start_for_memory(start_for_memory),
		.ready_for_memory(ready_for_memory)
	);
	
	initial clk = 0;
	always #5 clk = !clk;
	
	initial reset = 0;
	
	initial
	begin
		#15 reset = 1; start = 1; instruction_in = 32'h91000000; ready_for_memory = 1;
	end

endmodule