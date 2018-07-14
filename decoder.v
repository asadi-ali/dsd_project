module decoder(
	clk,
	reset,
	start,
	ready,
	instruction_in,
	instruction_out,
	start_for_memory,
	address_for_memory
);

	parameter byte = 8;
	parameter width_in = 2 * byte;
	parameter width_out = 4 * byte;
	parameter address_size = 16;

	parameter WAIT = 2'b00;
	parameter RUNNING = 2'b01;
	parameter SENDING = 2'b10;

	input clk;
	input reset;
	input start;
	output reg ready;
	input [width_in - 1:0] instruction_in;
	output reg [width_out - 1:0] instruction_out;
	output reg start_for_memory;
	output reg [address_size - 1:0] address_for_memory;

	reg [2:0] counter;
	reg [1:0] state;
	reg [1:0] next_state;
	reg send;
	reg done;

	always @(posedge clk)
	begin
		if (!reset)
		begin
			state <= WAIT;
		end
		else
			state <= next_state;
	end

	always @(*)
	begin
		next_state = state;
		case (state)
		WAIT:
		begin
			if (start)
				next_state = RUNNING;
		end
		RUNNING:
		begin
			if (send)
				next_state = SENDING;
			else if(done)
				next_state = WAIT;
		end
		SENDING:
		begin
			if(!send)
				next_state = RUNNING;
		end
		endcase
	end

	always @(*)
	begin
        if (!reset)
        begin
			next_state = WAIT;
			ready = 1;
			address_for_memory = 0;
			done = 0;
			send = 0;
			start_for_memory = 0;
			instruction_out = 0;
			counter = 0;
        end

		case (state)
		WAIT:
		begin
			done = 0;
			ready = 1;
			send = 0;
			start_for_memory = 0;
			instruction_out = 0;
			counter = 0;
		end
		RUNNING:
		begin
			ready = 0;
			case(instruction_in[7:0])

			8'b01101111: //ddiv
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b00011000: //dload
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100111;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
				begin
					instruction_out = 32'b10010010000000010000010011100110;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 2)
					done = 1;
			end

			8'b00100110: //dload_0
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b00100111: //dload_1
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b00101000: //dload_2
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b00101001: //dload_3
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b01101011: //dmul
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b01110111: //dneg
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b01110011: //drem
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b10101111: //dreturn
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b10010001: //i2b
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101000001011110000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100001101000001011110000011011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b10010010: //i2c
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101000001011100000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100001101000001011100000101011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b10000111: //i2d
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100001110010101010000000001010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101100001011000010001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100001101000001011000010101011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b00111010000000000000000000000101;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'b11100010100000001011000100000010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'b11100001111000001011000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'b11100010100000001011000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'b11100010100000001010000100000010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8) begin
                                instruction_out = 32'b11100011101100000001000000100000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9) begin
                                instruction_out = 32'b11100010010100010001000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 10) begin
                                instruction_out = 32'b11100001101100001011000010001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 11) begin
                                instruction_out = 32'b00111010111111111111111111111110;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 12) begin
                                instruction_out = 32'b11100011101100000010000000010100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 13) begin
                                instruction_out = 32'b11100001110000110011000000000011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 14) begin
                                instruction_out = 32'b11100001110001000100000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 15) begin
                                instruction_out = 32'b11100001101100001011000010001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 16) begin
                                instruction_out = 32'b11100000101001000011000000000011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 17) begin
                                instruction_out = 32'b11100001101000000011000010000011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 18) begin
                                instruction_out = 32'b11100010010100100010000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 19) begin
                                instruction_out = 32'b11100010010100100010000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 20) begin
                                instruction_out = 32'b11100001101000000011000010100011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 21) begin
                                instruction_out = 32'b11100000100010101010000000000011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 22) begin
                                instruction_out = 32'b11100010100000000001101100000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 23) begin
                                instruction_out = 32'b11100001101000000001101000000001;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 24) begin
                                instruction_out = 32'b11100000100010101010000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 25)
                                done = 1;
			end

			8'b10000110: //i2f
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001110000110011000000000011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100001101100001011000010001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b11100001101000001011000010101011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'b11100001101000001011000010101011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'b11100010100000001011000100000010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'b11100001111000001011000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'b11100010100000001011000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8) begin
                                instruction_out = 32'b11100010100000000011000100000010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9) begin
                                instruction_out = 32'b11100011101100000001000000100000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 10) begin
                                instruction_out = 32'b11100010010100010001000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 11) begin
                                instruction_out = 32'b11100001101100001011000010001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 12) begin
                                instruction_out = 32'b11100001101100001011000010001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 13) begin
                                instruction_out = 32'b11100011101100000010000000001001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 14) begin
                                instruction_out = 32'b11100001101100001011000010101011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 15) begin
                                instruction_out = 32'b11100010010100100010000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 16) begin
                                instruction_out = 32'b11100010010100100010000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 17) begin
                                instruction_out = 32'b11100010100000000001000010000000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 18) begin
                                instruction_out = 32'b11100001101000000001101110000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 19) begin
                                instruction_out = 32'b11100000100010101010000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 20) begin
                                instruction_out = 32'b11100000100010101010000000000011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 21) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 22)
                                done = 1;
			end

			8'b10000101: //i2l
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001110010101010000000001010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100001101100001011000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b01011010000000000000000000000101;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'b11100001111000001010000000010101;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 5) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6)
                                done = 1;
			end

			8'b10010011: //i2s
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101000001011100000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100001101000001011100000101011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b01100000: //iadd
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101100000001000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b11100000100000011011000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 4) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5)
                                done = 1;
			end

			8'b00101110: //iaload
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101100000001000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b11100111100100011011000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 4) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5)
                                done = 1;
			end

			8'b01111110: //iand
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101100000001000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b11100000000000011011000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 4) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5)
                                done = 1;
			end

			8'b01001111: //iastore
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101100000001000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b11100000000000010001000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 5) begin
                                instruction_out = 32'b11100101100000011011000000000000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6)
                                done = 1;
			end

			8'b00000011: //iconst_0
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100011101100001011000000000000;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 1) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2)
                                done = 1;
			end

			8'b00000100: //iconst_1
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100011101100001011000000000001;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 1) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2)
                                done = 1;
			end

			8'b00000101: //iconst_2
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100011101100001011000000000010;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 1) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2)
                                done = 1;
			end

			8'b00000110: //iconst_3
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100011101100001011000000000011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 1) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2)
                                done = 1;
			end

			8'b00000111: //iconst_4
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100011101100001011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 1) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2)
                                done = 1;
			end

			8'b00001000: //iconst_5
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100011101100001011000000000101;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 1) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2)
                                done = 1;
			end

			8'b10000000: //ior
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101100000001000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b11100001100000011011000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 4) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5)
                                done = 1;
			end

			8'b01110000: //irem
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b10101100: //ireturn
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b01111000: //ishl
			begin
                            if (counter == 0) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'b11100001101100000001000000001011;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'b11100101001111011011000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'b11100001101000001011101100010001;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 4) begin
                                instruction_out = 32'b11100101001111011010000000000100;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5)
                                done = 1;
			end

			8'b10001010: //l2d
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b10001001: //l2f
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b10001000: //l2i
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b01100001: //ladd
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b00101111: //laload
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b01111111: //land
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b01010000: //lastore
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b10010100: //lcmp
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b00001001: //lconst_0
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			8'b	00001010: //lconst_1
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end

			default:
			begin
				done = 1;
			end
			endcase
		end
		SENDING:
		begin
			start_for_memory = 0;
			send = 0;
			counter = counter + 1;
			address_for_memory = address_for_memory + 1;
		end
		endcase
	end
endmodule
