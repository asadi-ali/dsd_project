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
	
	wire [2:0] counter;
	wire [1:0] state;
	wire [1:0] next_state;
	wire send;
	wire done;
	
	decoder TB(
		.clk(clk),
		.reset(reset),
		.start(start),
		.ready(ready),
		.instruction_in(instruction_in),
		.instruction_out(instruction_out),
		.start_for_memory(start_for_memory),
		.ready_for_memory(ready_for_memory),
		
		
		
		.counter(counter),
		.state(state),
		.next_state(next_state),
		.send(send),
		.done(done)
	);
	
	initial clk = 0;
	always #5 clk = !clk;
	
	initial reset = 0;
	
	initial
	begin
	
		#15 reset = 1; start = 1; instruction_in = 32'h03000000; ready_for_memory = 1; // iconst_0
		
		#50 start = 0; instruction_in = 32'h04000000; ready_for_memory = 0; // iconst_1
		
		#5 ready_for_memory = 1; start = 1;
		
		#20 reset = 0;
		
		#15 reset = 1; instruction_in = 32'h6f000000; // ddiv
		
		#15 instruction_in = 32'h91000000; // i2b
		
		#15 instruction_in = 32'h50000000; // lastore

	end

endmodule