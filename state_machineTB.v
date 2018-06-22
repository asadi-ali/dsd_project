module state_machineTB;

	parameter byte = 8;
	parameter width_in = 1 * byte;
	parameter width_out = 1 * byte;
	parameter memory_size = 8;

	reg clk;
	reg reset;
	reg ready_from_decoder;
	wire start_for_decoder;
	reg [width_in - 1:0] data_from_memory;
	wire [width_out - 1:0] data_for_decoder;
	
	wire [memory_size - 1:0] memory_pointer;
	wire [1:0] state;
	wire [1:0] next_state;
	wire [width_out - 1:0] data;
	wire read_opcode;
	wire send;
	
	state_machine TB(
		.clk(clk), 
		.reset(reset), 
		.ready_from_decoder(ready_from_decoder), 
		.start_for_decoder(start_for_decoder), 
		.data_from_memory(data_from_memory), 
		.data_for_decoder(data_for_decoder),
		
		
		
		.memory_pointer(memory_pointer),
		.state(state),
		.next_state(next_state),
		.data(data),
		.read_opcode(read_opcode),
		.send(send)
	);
	
	initial clk = 0;
	always #5 clk = !clk;
	
	initial reset = 0;
	
	initial
	begin
	
		#10 reset = 1; ready_from_decoder = 1; data_from_memory = 8'b00000011; //iconst_0
		
		#30 data_from_memory = 8'b00000100; //iconst_1
		
		#30 ready_from_decoder = 0; data_from_memory = 8'b01101111; //ddiv
		
		#30 ready_from_decoder = 1;
		
		#30 data_from_memory = 8'b10010001; //i2b
				
		#30 data_from_memory = 8'b01010000; //lastore		
		
	end
	
endmodule