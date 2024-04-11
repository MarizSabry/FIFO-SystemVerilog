`include "transaction.sv"
program FIFO_tb (FIFO_IF.TB IF_tb);

FIFO_transaction my_trn;

initial begin
reset();

repeat(70) begin
my_trn = new();

//Controlling Constraints according to data width
if (my_trn.DATA_WIDTH <= 8) begin
my_trn.data_in_second_8.constraint_mode(0);
my_trn.data_in_third_8.constraint_mode(0);
my_trn.data_in_last_8.constraint_mode(0);
end
else if (8 < my_trn.DATA_WIDTH <= 16) begin
my_trn.data_in_third_8.constraint_mode(0);
my_trn.data_in_last_8.constraint_mode(0);
end
else if (16 < my_trn.DATA_WIDTH <= 24) begin
my_trn.data_in_last_8.constraint_mode(0);
end
else begin
my_trn.data_in_last_8.constraint_mode(1);
end

//Randomization
my_trn.randomize();

//Connecting the randomized signals with testbench signals
IF_tb.cb.Wr_enable <= my_trn.Wr_enable;
IF_tb.cb.data_in <= my_trn.data_in;
IF_tb.cb.Read_enable <= my_trn.Read_enable;

//Reading outputs & Printing
@(IF_tb.cb);

if(my_trn.Wr_enable) $display("Write EN:%b, Full Flag:%b, Data in:%b", 
				my_trn.Wr_enable, IF_tb.cb.full, my_trn.data_in);

else if (my_trn.Read_enable) $display("Read EN:%b, Empty Flag:%b, Data out:%b",
				my_trn.Read_enable, IF_tb.cb.empty, IF_tb.cb.data_out);

else $display("Write EN:%b, Read EN:%b, Full Flag:%b, Empty Flag:%b",
				my_trn.Wr_enable, my_trn.Read_enable, IF_tb.cb.full, IF_tb.cb.empty);

end

end

task reset();
@(IF_tb.cb);
IF_tb.cb.reset <= 1'b1; 
@(IF_tb.cb);
IF_tb.cb.reset <= 1'b0;
@(IF_tb.cb);
endtask

endprogram