module accelerator(
	clk,
	reset,
	rwn,
	data,
	address_test,
	
	rom_address,
	data_from_rom,
	instruction_in
);

	parameter address_size = 16;
	
	input clk, reset, rwn;
	input [address_size - 1:0] address_test;
	output [31:0] data;
	
	wire [7:0] adr_rom_state;
	wire [7:0] data_rom_state;
	
	wire ready_state_dec;
	wire start_state_dec;
	wire [15:0] data_state_dec;

	wire start_dec_mem;
	wire [31:0] data_dec_mem;
	wire [15:0] adr_dec_mem;

	
	output [7:0] rom_address;
	assign rom_address = adr_rom_state;
	
	output [7:0] data_from_rom;
	assign data_from_rom = data_rom_state;
	
	output [31:0] instruction_in;
	assign instruction_in = data_state_dec;
	
	rom r(.address(adr_rom_state), .data(data_rom_state));

	state_machine s(
		.clk(clk), .reset(reset), .ready_from_decoder(ready_state_dec), 
		.start_for_decoder(start_state_dec), .data_from_rom(data_rom_state), 
		.data_for_decoder(data_state_dec), .rom_address(adr_rom_state));

	decoder d(
		.clk(clk), .reset(reset), .start(start_state_dec), .ready(ready_state_dec),
		.instruction_in(data_state_dec), .instruction_out(data_dec_mem),
		.start_for_memory(start_dec_mem), .address_for_memory(adr_dec_mem));

	memory m(
		.clk(clk), .reset(reset), .address_dec(adr_dec_mem), .address_test(address_test), .data_in(data_dec_mem), 
		.data_out(data), .rwn(rwn), .start(start_dec_mem));

endmodule
