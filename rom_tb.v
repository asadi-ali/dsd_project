module rom_tb;
	reg [7:0] address;
	wire [7:0] data;
	rom rom1(address, data);
	initial begin
		address = 8'h00;
		#20
		address = 8'h01;
		#20
		address = 8'h02;
		#20
		address = 8'h03;
		#20
		address = 8'h04;
		#20
		address = 8'h05;
		#20
		address = 8'h06;
		#20
		address = 8'h07;
		#20
		address = 8'h08;
		#20
		address = 8'h09;
		#20
		address = 8'h0A;
		#20
		address = 8'h0B;
		#20
		address = 8'h0C;
		#20
		address = 8'h0D;
		#20
		address = 8'h0E;
		#20
		address = 8'h0F;
		#20
		address = 8'h10;
		#20
		$stop;
	end
endmodule 