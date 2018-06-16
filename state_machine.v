module state_machine(
	clk, 
	reset, 
	ready_from_decoder, 
	start_for_decoder, 
	pointer_for_memory, 
	data_from_memory, 
	data_for_decoder
);

	parameter byte = 8;
	parameter width_in = 1 * byte;
	parameter width_out = 2 * byte;
	parameter memory_size = 8;

	parameter READ_OPCODE = 2'b00;
	parameter READ_OPERAND = 2'b01;
	parameter SEND = 2'b10;

	input clk;
	input reset;
	input ready_from_decoder;
	output reg start_for_decoder;
	output reg [memory_size-1:0] pointer_for_memory;
	input [width_in-1:0] data_from_memory;
	output reg [width_out-1:0] data_for_decoder;

	reg [memory_size-1:0] memory_pointer;
	reg [1:0] state;
	reg [1:0] next_state;
	
	reg [width_out-1:0] data;
	reg read_opcode;
	reg send;


	always @(posedge clk)
	begin
		if (!reset)
		begin
			state <= READ_OPCODE;
			memory_pointer <= 0; 
			start_for_decoder <= 0;
			data_for_decoder <= 0;
		end
		else 
			state <= next_state;
	end

	always @(*)
	begin
		case (state)
			READ_OPCODE:
			begin
				if (read_opcode)
					next_state = SEND;
			end
			SEND:
			begin
				if (send)
					next_state = READ_OPCODE;
			end
		endcase
	end

	always @(*)
	begin
		case (state)
			READ_OPCODE:
			begin
				send = 0;
				if (ready_from_decoder)
				begin
					pointer_for_memory = memory_pointer;
					data[width_out-1:width_out-byte] = data_from_memory;
				end
			end
			SEND:
			begin
				read_opcode = 0;
				start_for_decoder = 1;
				data_for_decoder = data;
				send = 1;
				memory_pointer = memory_pointer + 1;
			end
		endcase
	end

endmodule 

