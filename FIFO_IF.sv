interface FIFO_IF #(parameter
    			ADDR_WIDTH    = 5,
    			DATA_WIDTH    = 8,
    			fifo_size     =2**ADDR_WIDTH
  			)
		(input bit clk);
    logic reset;
    logic Wr_enable;
    logic [DATA_WIDTH-1:0] data_in;
    logic Read_enable;
    logic full;
    logic empty;
    logic [DATA_WIDTH-1:0] data_out;

clocking cb @(posedge clk);
    output reset;
    output Wr_enable;
    output data_in;
    output Read_enable;
    input full;
    input empty;
    input data_out;
endclocking

modport TB (clocking cb);

endinterface