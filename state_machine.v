module state_machine(clk, ready_from_decoder, start_for_decoder, data_from_memory, data_for_decoder);

parameter size_for_fetch = 8;
parameter size_for_out_bus = 32;

input clk, ready_from_decoder;
input [size_for_fetch - 1:0] data_from_memory;
output reg start_for_decoder;
output reg [size_for_out_bus - 1:0] data_for_decoder;

endmodule 
