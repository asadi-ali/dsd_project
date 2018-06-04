module memory(clk,reset,address,data_in,data_out,rwn,start,ready);
	input clk,reset,start,rwn;
	input [31:0] address;
	input [31:0] data_in;
	output reg [31:0] data_out;
	output ready;
	reg [7:0] array[1023:0];
	reg state;
	reg [9:0] ad_t;
	reg [31:0] data_t;
	reg [1:0] counter;
	reg rwn_t;
	integer i;
	assign ready=~state;
	always @(posedge clk or posedge reset)
	begin
		if(reset) begin
			for(i=0; i<1023; i=i+1) begin
				array[i] <= 8'h00;
			end
			array[0] <= 8'hf0;
			array[1] <= 8'hd0;
			array[2] <= 8'ha0;
			array[3] <= 8'h01;
			
			state=0;
		end
		else if(start & ~state) begin
			ad_t=address[9:0];
			rwn_t=rwn;
			data_t=data_in;
			counter=address[1:0];
			state=1;
		end
		else if(|counter && state)
			counter=counter-1;
		else if(state) begin
			if(rwn_t)
				data_out={array[(ad_t+3)%1024], array[(ad_t+2)%1024], array[(ad_t+1)%1024], array[ad_t]};
			else begin
				array[ad_t] <= data_t[9:0];
				array[(ad_t+1)%1024] <= data_t[15:8];
				array[(ad_t+2)%1024] <= data_t[23:16];
				array[(ad_t+3)%1024] <= data_t[31:24];
			end
			state=0;
		end
	end
endmodule
