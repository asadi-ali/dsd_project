module state_machine(clk, reset, pointer, ready_from_decoder, start_for_decoder, data_from_memory, data_for_decoder);

parameter size_for_fetch = 8;
parameter size_for_out_bus = 32;
parameter start_address_of_rom = 0;
parameter size_of_state = 3;
parameter size_of_pointer = 9;

input clk, ready_from_decoder, reset;
input [size_for_fetch - 1:0] data_from_memory;
output reg start_for_decoder;
output reg [size_for_out_bus - 1:0] data_for_decoder;
output reg [size_of_pointer - 1:0] pointer = 9'b000000001;

reg [size_of_state - 1:0] state = 0;

integer counter = 0;
integer left = size_for_out_bus - 1;
integer right = size_for_out_bus - 8;



always@(posedge reset)begin
	pointer <= start_address_of_rom;
	start_for_decoder <= 1'b0;
	state <= 3'b001;
	//left <= size_for_out_bus - 1;
	//right <= size_for_out_bus - 8;
	counter <= 0;
end

always@(posedge clk)begin
	case(state)
		3'b001 : begin
			data_for_decoder[size_for_out_bus - 1:size_for_out_bus - 8] <= data_from_memory;
			pointer <= pointer + 9'b000001000;
			start_for_decoder <= 1'b0;
			//left <= left - 8;
			//right <= right - 8;
			if (data_from_memory == 8'b0001_1000)begin
				counter <= 1;
				state <= 3'b010;
				end
			else begin
				counter <= 0;
				state <= 3'b100;
				end
				
			end
		3'b010 : begin
			data_for_decoder[size_for_out_bus - 9:size_for_out_bus - 16] <= data_from_memory;
			pointer <= pointer + 9'b000001000;
			counter <= counter - 1;
			//right <= right - 8;
			//left <= left - 8;
			if (counter == 0)
				state <= 3'b100;
			else 
				state <= 3'b011;
			end
		3'b011 : begin
			data_for_decoder[size_for_out_bus - 17:size_for_out_bus - 24] <= data_from_memory;
			pointer <= pointer + 9'b000001000;
			counter <= counter - 1;
			//right <= right - 8;
			//left <= left - 8;
			state <= 3'b100;
			end
		3'b100 : begin
			start_for_decoder <= 1;
			//left <= size_for_out_bus - 1;
			//right <= size_for_out_bus - 8;
			if (ready_from_decoder == 1'b1)
				state <= 3'b001;
			else
				state <= 3'b100;
			end
	endcase
end

endmodule 
