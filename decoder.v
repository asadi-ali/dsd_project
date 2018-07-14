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
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE53D5004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE53D4004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE1A00A24;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE3C00B02;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE1A01A2A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'hE3C11B02;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8) begin
                                instruction_out = 32'hE2800B01;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9) begin
                                instruction_out = 32'hE2400001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 10) begin
                                instruction_out = 32'hE0400001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 11) begin
                                instruction_out = 32'hE024100A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 12) begin
                                instruction_out = 32'hE2011102;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 13) begin
                                instruction_out = 32'hE1A04604;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 14) begin
                                instruction_out = 32'hE1A04624;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 15) begin
                                instruction_out = 32'hE2844601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 16) begin
                                instruction_out = 32'hE1A0A60A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 17) begin
                                instruction_out = 32'hE1A0A62A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 18) begin
                                instruction_out = 32'hE28AA601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 19) begin
                                instruction_out = 32'hE154000A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 20) begin
                                instruction_out = 32'hCA000004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 21) begin
                                instruction_out = 32'h0155000B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 22) begin
                                instruction_out = 32'hAA000002;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 23) begin
                                instruction_out = 32'hE2800001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 24) begin
                                instruction_out = 32'hE1A0A0AA;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 25) begin
                                instruction_out = 32'hE1A0B06B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 26) begin
                                instruction_out = 32'hE1C22002;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 27) begin
                                instruction_out = 32'hE1C33003;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 28) begin
                                instruction_out = 32'hE3A06015;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 29) begin
                                instruction_out = 32'hE1A02082;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 30) begin
                                instruction_out = 32'hE154000A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 31) begin
                                instruction_out = 32'h0155000B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 32) begin
                                instruction_out = 32'hBA000008;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 33) begin
                                instruction_out = 32'hE2822001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 34) begin
                                instruction_out = 32'hE044400A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 35) begin
                                instruction_out = 32'hE155000B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 36) begin
                                instruction_out = 32'hA045500B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 37) begin
                                instruction_out = 32'hAA000003;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 38) begin
                                instruction_out = 32'hE2444001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 39) begin
                                instruction_out = 32'hE1E0700B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 40) begin
                                instruction_out = 32'hE2877001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 41) begin
                                instruction_out = 32'hE0855007;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 42) begin
                                instruction_out = 32'hE1A04084;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 43) begin
                                instruction_out = 32'hE1A05085;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 44) begin
                                instruction_out = 32'hE2A44000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 45) begin
                                instruction_out = 32'hE2566001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 46) begin
                                instruction_out = 32'hCAFFFFED;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 47) begin
                                instruction_out = 32'hE2222601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 48) begin
                                instruction_out = 32'hE3A06020;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 49) begin
                                instruction_out = 32'hE1A03083;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 50) begin
                                instruction_out = 32'hE154000A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 51) begin
                                instruction_out = 32'h0155000B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 52) begin
                                instruction_out = 32'hBA000008;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 53) begin
                                instruction_out = 32'hE2833001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 54) begin
                                instruction_out = 32'hE044400A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 55) begin
                                instruction_out = 32'hE155000B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 56) begin
                                instruction_out = 32'hA045500B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 57) begin
                                instruction_out = 32'hAA000003;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 58) begin
                                instruction_out = 32'hE2444001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 59) begin
                                instruction_out = 32'hE1E0700B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 60) begin
                                instruction_out = 32'hE2877001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 61) begin
                                instruction_out = 32'hE0855007;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 62) begin
                                instruction_out = 32'hE1A04084;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 63) begin
                                instruction_out = 32'hE1A05085;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 64) begin
                                instruction_out = 32'hE2A44000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 65) begin
                                instruction_out = 32'hE2566001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 66) begin
                                instruction_out = 32'hCAFFFFED;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 67) begin
                                instruction_out = 32'hE0222001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 68) begin
                                instruction_out = 32'hE0222A00;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 69) begin
                                instruction_out = 32'hE48D2004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 70) begin
                                instruction_out = 32'hE48D3004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 71)
                                done = 1;
			end

			8'b00011000: //dload
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE59CA015;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE59CB018;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b00100110: //dload_0
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE59CA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE59CB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b00100111: //dload_1
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE59CA008;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE59CB00C;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b00101000: //dload_2
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE59CA010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE59CB014;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b00101001: //dload_3
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE59CA018;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE59CB01C;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b01101011: //dmul
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE53D5004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE53D4004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE1A00A24;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE3C00B02;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE1A01A2A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'hE3C11B02;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8) begin
                                instruction_out = 32'hE0800001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9) begin
                                instruction_out = 32'hE2800001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 10) begin
                                instruction_out = 32'hE2400B01;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 11) begin
                                instruction_out = 32'hE024100A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 12) begin
                                instruction_out = 32'hE2011102;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 13) begin
                                instruction_out = 32'hE1A04604;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 14) begin
                                instruction_out = 32'hE1A04624;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 15) begin
                                instruction_out = 32'hE2844601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 16) begin
                                instruction_out = 32'hE1A0A60A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 17) begin
                                instruction_out = 32'hE1A0A62A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 18) begin
                                instruction_out = 32'hE28AA601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 19) begin
                                instruction_out = 32'hE1C22002;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 20) begin
                                instruction_out = 32'hE1C33003;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 21) begin
                                instruction_out = 32'hE3A06035;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 22) begin
                                instruction_out = 32'hE35A0601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 23) begin
                                instruction_out = 32'hBA000001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 24) begin
                                instruction_out = 32'hE0833005;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 25) begin
                                instruction_out = 32'hE0A22004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 26) begin
                                instruction_out = 32'hE3CAA601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 27) begin
                                instruction_out = 32'hE1A0A08A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 28) begin
                                instruction_out = 32'hE1A0B08B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 29) begin
                                instruction_out = 32'hE2AAA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 30) begin
                                instruction_out = 32'hE1A040A4;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 31) begin
                                instruction_out = 32'hE1A05065;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 32) begin
                                instruction_out = 32'hE2566001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 33) begin
                                instruction_out = 32'hAAFFFFF3;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 34) begin
                                instruction_out = 32'hE3520602;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 35) begin
                                instruction_out = 32'hBA000002;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 36) begin
                                instruction_out = 32'hE1A020A2;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 37) begin
                                instruction_out = 32'hE1A03063;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 38) begin
                                instruction_out = 32'hE2800001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 39) begin
                                instruction_out = 32'hE2222601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 40) begin
                                instruction_out = 32'hE0222001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 41) begin
                                instruction_out = 32'hE0222A00;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 42) begin
                                instruction_out = 32'hE48D2004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 43) begin
                                instruction_out = 32'hE48D3004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 44)
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
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE53D5004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE53D4004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE1A00A24;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE3C00B02;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE1A01A2A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'hE3C11B02;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8) begin
                                instruction_out = 32'hE2800B01;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9) begin
                                instruction_out = 32'hE2400001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 10) begin
                                instruction_out = 32'hE0400001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 11) begin
                                instruction_out = 32'hE1A02001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 12) begin
                                instruction_out = 32'hE024100A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 13) begin
                                instruction_out = 32'hE2011102;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 14) begin
                                instruction_out = 32'hE1A04604;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 15) begin
                                instruction_out = 32'hE1A04624;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 16) begin
                                instruction_out = 32'hE2844601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 17) begin
                                instruction_out = 32'hE1A0A60A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 18) begin
                                instruction_out = 32'hE1A0A62A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 19) begin
                                instruction_out = 32'hE28AA601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 20) begin
                                instruction_out = 32'hE154000A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 21) begin
                                instruction_out = 32'h0155000B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 22) begin
                                instruction_out = 32'hAA000003;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 23) begin
                                instruction_out = 32'hE2800001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 24) begin
                                instruction_out = 32'hE2811001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 25) begin
                                instruction_out = 32'hE1A0A0AA;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 26) begin
                                instruction_out = 32'hE1A0B06B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 27) begin
                                instruction_out = 32'hE154000A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 28) begin
                                instruction_out = 32'h0155000B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 29) begin
                                instruction_out = 32'hBA000007;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 30) begin
                                instruction_out = 32'hE044400A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 31) begin
                                instruction_out = 32'hE155000B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 32) begin
                                instruction_out = 32'hA045500B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 33) begin
                                instruction_out = 32'hAA000003;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 34) begin
                                instruction_out = 32'hE2444001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 35) begin
                                instruction_out = 32'hE1E0700B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 36) begin
                                instruction_out = 32'hE2877001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 37) begin
                                instruction_out = 32'hE0855007;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 38) begin
                                instruction_out = 32'hE1A04084;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 39) begin
                                instruction_out = 32'hE1A05085;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 40) begin
                                instruction_out = 32'hE2A44000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 41) begin
                                instruction_out = 32'hE2500001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 42) begin
                                instruction_out = 32'hAAFFFFEF;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 43) begin
                                instruction_out = 32'hE35A0601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 44) begin
                                instruction_out = 32'hAA000004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 45) begin
                                instruction_out = 32'hE2422001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 46) begin
                                instruction_out = 32'hE1A0A08A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 47) begin
                                instruction_out = 32'hE1A0B08B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 48) begin
                                instruction_out = 32'hE2AAA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 49) begin
                                instruction_out = 32'hEAFFFFF8;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 50) begin
                                instruction_out = 32'hE22AA601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 51) begin
                                instruction_out = 32'hE02AA001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 52) begin
                                instruction_out = 32'hE02AAA02;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 53) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 54) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 55)
                                done = 1;
			end

			8'b10101111: //dreturn
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE22AA102;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 4) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5)
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
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE20A0102;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE3500000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'h0A000003;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE1E0A00A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE1E0B00B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'hE28BB001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8) begin
                                instruction_out = 32'hE2AAA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9) begin
                                instruction_out = 32'hE3A01B01;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 10) begin
                                instruction_out = 32'hE2811033;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 11) begin
                                instruction_out = 32'hE35A0000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 12) begin
                                instruction_out = 32'h035B0000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 13) begin
                                instruction_out = 32'h03A0B000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 14) begin
                                instruction_out = 32'h048DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 15) begin
                                instruction_out = 32'h048DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 16) begin
                                instruction_out = 32'h0A000010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 17) begin
                                instruction_out = 32'hE35A0601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 18) begin
                                instruction_out = 32'hAA000004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 19) begin
                                instruction_out = 32'hE1A0A08A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 20) begin
                                instruction_out = 32'hE1A0B08B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 21) begin
                                instruction_out = 32'hE2AAA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 22) begin
                                instruction_out = 32'hE2411001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 23) begin
                                instruction_out = 32'hEAFFFFF8;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 24) begin
                                instruction_out = 32'hE35A0602;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 25) begin
                                instruction_out = 32'hBA000002;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 26) begin
                                instruction_out = 32'hE1A0A0AA;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 27) begin
                                instruction_out = 32'hE1A0B06B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 28) begin
                                instruction_out = 32'hE2811001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 29) begin
                                instruction_out = 32'hE3CAA601;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 30) begin
                                instruction_out = 32'hE02AA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 31) begin
                                instruction_out = 32'hE02AAB81;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 32) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 33) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 34)
                                done = 1;
			end

			8'b10001001: //l2f
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE20A0102;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE3500000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'h0A000003;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE1E0A00A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE1E0B00B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'hE28BB001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8) begin
                                instruction_out = 32'hE2AAA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9) begin
                                instruction_out = 32'hE3A010B6;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 10) begin
                                instruction_out = 32'hE35A0000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 11) begin
                                instruction_out = 32'h035B0000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 12) begin
                                instruction_out = 32'h03A0B000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 13) begin
                                instruction_out = 32'h048DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 14) begin
                                instruction_out = 32'h048DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 15) begin
                                instruction_out = 32'h0A000010;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 16) begin
                                instruction_out = 32'hE35A0502;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 17) begin
                                instruction_out = 32'hAA000004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 18) begin
                                instruction_out = 32'hE1A0A08A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 19) begin
                                instruction_out = 32'hE1A0B08B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 20) begin
                                instruction_out = 32'hE2AAA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 21) begin
                                instruction_out = 32'hE2411001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 22) begin
                                instruction_out = 32'hEAFFFFF8;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 23) begin
                                instruction_out = 32'hE35A0401;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 24) begin
                                instruction_out = 32'hBA000002;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 25) begin
                                instruction_out = 32'hE1A0A0AA;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 26) begin
                                instruction_out = 32'hE1A0B06B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 27) begin
                                instruction_out = 32'hE2811001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 28) begin
                                instruction_out = 32'hE3CAA502;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 29) begin
                                instruction_out = 32'hE02AA000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 30) begin
                                instruction_out = 32'hE02AAB81;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 31) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 32) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 33)
                                done = 1;
			end

			8'b10001000: //l2i
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE3CBB102;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE20AA102;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE02BB00A;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 6) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7)
                                done = 1;
			end

			8'b01100001: //ladd
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE53D5004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE53D4004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE08BB005;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE0AAA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 7) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8)
                                done = 1;
			end

			8'b00101111: //laload
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE53D3004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE53D2004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE793400B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE28BB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE793500B;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'hE48D4004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 8) begin
                                instruction_out = 32'hE48D5004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9)
                                done = 1;
			end

			8'b01111111: //land
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE53D5004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE53D4004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE00BB005;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE00AA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 7) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8)
                                done = 1;
			end

			8'b01010000: //lastore
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53D5004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53D4004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE53D3004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE53D2004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE53DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'hE53DA004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'hE783A005;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'hE2855004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 8) begin
                                instruction_out = 32'hE783B005;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9)
                                done = 1;
			end

			8'b10010100: //lcmp
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE53D5004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE53D4004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE53D3004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 3) begin
                                instruction_out = 32'hE53D2004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4) begin
                                instruction_out = 32'hE1520004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 5) begin
                                instruction_out = 32'h01530005;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 6) begin
                                instruction_out = 32'h03A0B000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 7) begin
                                instruction_out = 32'hC3A0B001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 8) begin
                                instruction_out = 32'hB3E0B000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 9) begin
                                instruction_out = 32'hE3A0A000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 10) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 11) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 12)
                                done = 1;
			end

			8'b00001001: //lconst_0
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE3A0A000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE3A0B000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
                                done = 1;
			end

			8'b	00001010: //lconst_1
			begin
                            if (counter == 0) begin
                                instruction_out = 32'hE3A0A000;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 1) begin
                                instruction_out = 32'hE3A0B001;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 2) begin
                                instruction_out = 32'hE48DA004;
                                start_for_memory = 1;
                                send = 1;
                            end

                            if (counter == 3) begin
                                instruction_out = 32'hE48DB004;
                                start_for_memory = 1;
                                send = 1;
                            end
                            if (counter == 4)
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
