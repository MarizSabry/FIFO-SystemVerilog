class FIFO_transaction #(parameter
    ADDR_WIDTH  = 5,
    DATA_WIDTH  = 8,
    fifo_size   =2**ADDR_WIDTH
  );
         bit reset;
    rand bit Wr_enable;
    rand bit [DATA_WIDTH-1:0] data_in;
    rand bit Read_enable;
         bit full;
         bit empty;
         bit [DATA_WIDTH-1:0] data_out;


//Constrains
constraint data_in_first_8 { data_in[7:0] inside  {['d100:'d230]};}

constraint data_in_second_8{ data_in[15:8] inside {['d200:'d255]};}
constraint data_in_third_8 { data_in[23:16] dist  {['d000:'d100] :/ 30, 
						   ['d100:'d200] :/ 60, 
						   ['d200:'d255] :/ 10};}

constraint data_in_last_8  { data_in[7:0] > 'd150  -> data_in[31:24] inside {['d0:'d50]};
			     data_in[7:0] <= 'd150 -> data_in[31:24] inside {['d0:'d250]};}

constraint Control_signals { Read_enable dist {0:=2 , 1:=1};
			     Wr_enable   dist {0:=1 , 1:=2};}

endclass
