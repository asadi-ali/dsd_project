module memory(clk,reset,address,data_in,data_out,rwn,start,ready);
	input clk,reset,start,rwn;
	input [15:0] address;
	input [31:0] data_in;
	output reg [31:0] data_out;
	output ready;
	reg [31:0] array[4097:0];
	reg state;
	reg [15:0] ad_t;
	reg [31:0] data_t;
	reg rwn_t;
	integer i;
	assign ready=~state;
	always @(posedge clk or posedge reset)
	begin
		if(reset) begin
			for(i=0; i<4098; i=i+1) begin
				array[i] <= 8'h00;
			end
			state=0;
		end
		else if(start & ~state) begin
			ad_t=address[11:0];
			rwn_t=rwn;
			data_t=data_in;
			state=1;
		end
		else if(state) begin
			if(rwn_t)
				data_out = array[ad_t];
			else begin
				array[ad_t] <= data_t[31:0];
			end
			state=0;
		end
	end
endmodule
