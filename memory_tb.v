module memory_tb;
	reg [15:0] address_dec;
	reg [15:0] address_test;
	reg [31:0] data_in;
	reg start, clk, reset, rwn;
	wire [31:0] data_out;
	memory memory1(clk, reset, address_dec, address_test, data_in, data_out, rwn, start);
	initial begin
		start = 1;
		reset = 1;
		rwn = 0;
		clk = 0;
	end
	always #5 clk = !clk;
	initial begin
		#1
		address_dec = 16'h0000;
		data_in = 32'h00000000;
		#20
		address_dec = 16'h0001;
		data_in = 32'h11111111;
		#20
		address_dec = 16'h0002;
		data_in = 32'h22222222;
		#20
		address_dec = 16'h0003;
		data_in = 32'h33333333;
		#20
		address_dec = 16'h0004;
		data_in = 32'h44444444;
		#20
		address_dec = 16'h0005;
		data_in = 32'h55555555;
		#20
		address_dec = 16'h0006;
		data_in = 32'h66666666;
		#20
		address_dec = 16'h0007;
		data_in = 32'h77777777;
		#20
		address_dec = 16'h0008;
		data_in = 32'h88888888;
		#20
		address_dec = 16'h0009;
		data_in = 32'h99999999;
		#20
		address_dec = 16'h000A;
		data_in = 32'hAAAAAAAA;
		#20
		address_dec = 16'h000B;
		data_in = 32'hBBBBBBBB;
		#20
		address_dec = 16'h000C;
		data_in = 32'hCCCCCCCC;
		#20
		address_dec = 16'h000D;
		data_in = 32'hDDDDDDDD;
		#20
		address_dec = 16'h000E;
		data_in = 32'hEEEEEEEE;
		#20
		address_dec = 16'h000F;
		data_in = 32'hFFFFFFFF;
		#20
		rwn = 1;
		address_test = 16'h0000;
		#20
		address_test = 16'h0001;
		#20
		address_test = 16'h0002;
		#20
		address_test = 16'h0003;
		#20
		address_test = 16'h0004;
		#20
		address_test = 16'h0005;
		#20
		address_test = 16'h0006;
		#20
		address_test = 16'h0007;
		#20
		address_test = 16'h0008;
		#20
		address_test = 16'h0009;
		#20
		address_test = 16'h000A;
		#20
		address_test = 16'h000B;
		#20
		address_test = 16'h000C;
		#20
		address_test = 16'h000D;
		#20
		address_test = 16'h000E;
		#20
		address_test = 16'h000F;
		#20
		$stop;
	end
endmodule 