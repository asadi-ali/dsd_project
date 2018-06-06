module memory(clk,reset,address,data_in,data_out,rwn,start);
	input clk,reset,start,rwn;
	input [15:0] address;
	input [31:0] data_in;
	output reg [31:0] data_out;
	reg [31:0] array[4097:0];
	reg state = 0;
	reg [15:0] ad_t;
	reg [31:0] data_t;
	reg rwn_t;
	integer i;
	always @(posedge clk or reset)
	begin	
		if(~reset) begin
			for(i=0; i<4098; i=i+1) begin
				array[i] <= 32'h00000000;
			end
			state=0;
		end
		else if(start) begin
			ad_t=address[11:0];
			if(rwn)
				data_out = array[ad_t];
			else begin
				array[ad_t] <= data_in[31:0];
			end
			state=0;
		end
	end
endmodule
