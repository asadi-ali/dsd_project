module acceleratorTB;

	parameter address_size = 16;

	reg clk;
	reg reset;
	reg rwn;
	reg [address_size - 1:0] address_test;
	wire [31:0] data;
	
	
	wire [7:0] rom_address;
	wire [7:0] data_from_rom;
	wire [31:0]	instruction_in;
	wire [31:0]	instruction_out;

	
	accelerator TB(
		.clk(clk),
		.reset(reset),
		.rwn(rwn),
		.address_test(address_test),
		.data(data),
		
		
		
		
		.rom_address(rom_address),
		.data_from_rom(data_from_rom),
		.instruction_in(instruction_in),
		.instruction_out(instruction_out)
	);
	
	initial clk = 0;
	always #5 clk = !clk;
	
	initial reset = 0;
	
	initial
	begin
	
		#15 reset = 1;
		
		#15 rwn = 0;
			
		#1000 rwn = 1; address_test = 16'h0000;
		#100 rwn = 1; address_test = 16'h0001;
		#100 rwn = 1; address_test = 16'h0002;
		#100 rwn = 1; address_test = 16'h0003;
		#100 rwn = 1; address_test = 16'h0004;
		#100 rwn = 1; address_test = 16'h0005;

				

	end
	
endmodule
