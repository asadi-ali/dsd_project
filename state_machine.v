module state_machine(
	clk, 
	reset, 
	ready_from_decoder, 
	start_for_decoder, 
	data_from_memory, 
	data_for_decoder,
	
	
	
	memory_pointer,
	state,
	next_state,
	data,
	read_opcode,
	send
);

	parameter byte = 8;
	parameter width_in = 1 * byte;
	parameter width_out = 1 * byte;
	parameter memory_size = 8;

	parameter READ_OPCODE = 2'b00;
	parameter READ_OPERAND = 2'b01;
	parameter SEND = 2'b10;

	input clk;
	input reset;
	input ready_from_decoder;
	output reg start_for_decoder;
	input [width_in - 1:0] data_from_memory;
	output reg [width_out - 1:0] data_for_decoder;

	output reg [memory_size - 1:0] memory_pointer;
	output reg [1:0] state;
	output reg [1:0] next_state;
	
	output reg [width_out - 1:0] data;
	output reg read_opcode;
	output reg send;


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
		begin
			state <= next_state;
			read_opcode = 1;
		end
	end

	always @(*)
	begin
		next_state = state;
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
				read_opcode = 0;
				send = 0;
				if (ready_from_decoder)
				begin
					data = data_from_memory;
				end
			end
			SEND:
			begin
				read_opcode = 1;
				start_for_decoder = 1;
				data_for_decoder = data;
				send = 1;
				memory_pointer = memory_pointer + 1;
			end
		endcase
	end

endmodule 