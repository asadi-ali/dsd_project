module decoder(
	clk,
	start,
	instruction_in,
	instruction_out,
	ready
);
	parameter byte = 8;
	parameter width_in = 4 * byte;
	parameter width_out = 4 * byte;

	input clk;
	input start;
	input [width_in-1:0] instruction_in;
	output reg [width_out-1:0] instruction_out;
	output reg ready;

	always @(posedge clk)
	begin
		case(instruction_in[width_in-1:width_in-1-byte])
			8'b00000000:
			begin
			end
			default:
			begin
			end
		endcase
	end
endmodule 
