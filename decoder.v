module decoder(
	input clk,
	input start,
	input[width_in-1:0] reg instruction_in,
	output[width_out-1:0] reg instruction_out,
	output reg ready
)
parameter byte = 8;
parameter width_in = 4 * byte;
parameter width_out = 4 * byte;

always @(posedge clk)
begin
	case(instruction_in[width_in-1:width-1-byte])
		8'b00000000:
		begin
		end
		default:
		begin
		end
	endcase
end
endmodule 
