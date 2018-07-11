module state_machine(
	clk,
	reset,
	ready_from_decoder,
	start_for_decoder,
	data_from_rom,
	data_for_decoder,
	rom_address
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
	input [width_in - 1:0] data_from_rom;
	output reg [width_out - 1:0] data_for_decoder;
	output reg [memory_size - 1:0] rom_address;

	reg [1:0] state;
	reg [1:0] next_state;

	reg [width_out - 1:0] data;
	reg read_opcode;
	reg send;

	always @(posedge clk)
	begin
		if (!reset)
		begin
			state <= READ_OPCODE;
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
        if (!reset)
        begin
			rom_address = 0;
			start_for_decoder = 0;
			data_for_decoder = 0;
        end

		case (state)
			READ_OPCODE:
			begin
				read_opcode = 0;
				send = 0;
				if (ready_from_decoder)
				begin
					data = data_from_rom;
				end
			end
			SEND:
			begin
				if (send == 0)
				begin
					read_opcode = 1;
					start_for_decoder = 1;
					data_for_decoder = data;
					send = 1;
					rom_address = rom_address + 1;
				end
			end
		endcase
	end

endmodule
