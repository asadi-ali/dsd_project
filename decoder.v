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
			next_state <= WAIT;
			ready <= 1;
			address_for_memory <= 0;
			done <= 0;
			send <= 0;
			start_for_memory <= 0;
			instruction_out <= 0;
			counter <= 0;
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
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
					done = 1;
			end
			
			8'b10010010: //i2c
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
			
			8'b10000111: //i2d
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
			
			8'b10000110: //i2f
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
			
			8'b10000101: //i2l
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
			
			8'b10010011: //i2s
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
			
			8'b01100000: //iadd
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
			
			8'b00101110: //iaload
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
			
			8'b01111110: //iand
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
			
			8'b01001111: //iastore
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
			
			8'b00000011: //iconst_0
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
			
			8'b00000100: //iconst_1
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
			
			8'b00000101: //iconst_2
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
			
			8'b00000110: //iconst_3
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
			
			8'b00000111: //iconst_4
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
			
			8'b00001000: //iconst_5
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
			
			8'b10000000: //ior
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
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
					start_for_memory = 1;
					send = 1;
				end
				if (counter == 1)
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