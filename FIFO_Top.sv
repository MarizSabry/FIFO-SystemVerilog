module FIFO_top;

bit clk;
always #5 clk = ~clk;

localparam ADDR_WIDTH = 5;
localparam DATA_WIDTH = 8;
localparam fifo_size  = 2**ADDR_WIDTH;

FIFO_IF #(ADDR_WIDTH, DATA_WIDTH, fifo_size) FIFO_io(clk);
FIFO_tb FIFO_TB(FIFO_io);
FIFO #(.ADDR_WIDTH(5),
       .DATA_WIDTH(8),
       .fifo_size(2**ADDR_WIDTH)) DUT (
.clk(FIFO_io.clk),
.reset(FIFO_io.reset),
.Wr_enable(FIFO_io.Wr_enable),
.data_in(FIFO_io.data_in),
.Read_enable(FIFO_io.Read_enable),
.full(FIFO_io.full),
.empty(FIFO_io.empty),
.data_out(FIFO_io.data_out)
);

bind FIFO assertions #(	.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .fifo_size(fifo_size)) inst (
.clk(clk),
.reset(reset),
.Wr_enable(Wr_enable),
.data_in(data_in),
.Read_enable(Read_enable),
.full(full),
.empty(empty),
.data_out(data_out)
);

//Coverpoints
covergroup FIFO_CovGrp @(posedge clk);
	coverpoint FIFO_io.empty {
			bins empty_0 = {0};
			bins empty_1 = {1};}
	coverpoint FIFO_io.full {
			bins full_0 = {0};
			bins full_1 = {1};}
endgroup

FIFO_CovGrp FIFO_cg;

initial begin
FIFO_cg = new();
end

endmodule
