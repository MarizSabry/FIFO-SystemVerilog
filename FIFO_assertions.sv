module assertions #(parameter
    	ADDR_WIDTH = 5,
    	DATA_WIDTH = 8,
    	fifo_size  =2**ADDR_WIDTH)
 (
    input 	clk,
    input 	reset,
    input 	Wr_enable,
    input  reg 	[DATA_WIDTH-1:0] data_in,
    input 	Read_enable,
    input 	full,
    input 	empty,
    input reg [DATA_WIDTH-1:0] data_out
  ); 

property write_pointer;
@(posedge clk)
disable iff (FIFO_top.DUT.write_ptr == 5'h00) (Wr_enable && !full) |=> (FIFO_top.DUT.write_ptr == $past(FIFO_top.DUT.write_ptr + 1));
endproperty
assert property (write_pointer) $display("Assertion 1 Write Pointer: Correct");

property Read_ptr;
@(posedge clk)
disable iff (FIFO_top.DUT.read_ptr == 5'h00) (!empty && Read_enable) |=> (FIFO_top.DUT.read_ptr == $past(FIFO_top.DUT.read_ptr + 1));
endproperty
assert property (Read_ptr) $display("Assertion 2 Read Pointer: Correct");

property empty_flag;
@(posedge clk) (FIFO_top.DUT.write_ptr == FIFO_top.DUT.read_ptr) |-> empty;
endproperty
assert property (empty_flag) $display("Assertion 3 Empty Flag: Correct");

property full_flag;
@(posedge clk) (FIFO_top.DUT.read_ptr == (FIFO_top.DUT.write_ptr +1) ) |-> full;
endproperty
assert property (full_flag) $display("Assertion 4 Full Flag: Correct");
 
endmodule
