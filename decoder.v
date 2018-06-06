module decoder(
	clk,
	reset,
	start,
	ready,
	instruction_in,
	instruction_out,
	start_for_memory,
	ready_for_memory,
);
	parameter byte = 8;
	parameter width_in = 4 * byte;
	parameter width_out = 4 * byte;

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
	input ready_for_memory;

	reg [2:0] counter;
	reg [1:0] state;
	reg [1:0] next_state;
	reg send;
	reg done;

	
	
	always @(posedge clk) 
	begin 
		if (!reset)
			state <= WAIT;
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
			case(instruction_in[width_in - 1:width_in - byte])
			8'b10010001: //i2b
			begin
				if (counter == 0)
				begin
					instruction_out = 32'b10010010000000010000010011100000;
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
			if (send) 
			begin
				if (ready_for_memory)
				begin
					start_for_memory = 0;
					send = 0;
					counter = counter + 1;
				end
				else
					start_for_memory = 1;
			end
		end
		endcase
	end
endmodule 