module accelerator(
	input clk,
	input reset,
	input rwn,
	output [31:0] data
);

	wire [7:0] adr_rom_state;
	wire [7:0] data_rom_state;
	
	wire ready_state_dec;
	wire start_state_dec;
	wire [15:0] data_state_dec;

	wire start_dec_mem;
	wire [31:0] data_dec_mem;
	wire [15:0] adr_dec_mem;

	rom r(.address(adr_rom_state), .data(data_rom_state));

	state_machine s(
		.clk(clk), .reset(reset), .ready_from_decoder(ready_state_dec), 
		.start_for_decoder(start_state_dec), .data_from_memory(data_rom_state), 
		.data_for_decoder(data_state_dec), .memory_pointer(adr_rom_state));

	decoder d(
		.clk(clk), .reset(reset), .start(start_state_dec), .ready(ready_state_dec),
		.instruction_in(data_state_dec), .instruction_out(data_dec_mem),
		.start_for_memory(start_dec_mem), .address_for_memory(adr_dec_mem));

	memory m(
		.clk(clk), .reset(reset), .address(adr_dec_mem), .data_in(data_dec_mem), 
		.data_out(data), .rwn(rwn), .start(start_dec_mem));

endmodule
