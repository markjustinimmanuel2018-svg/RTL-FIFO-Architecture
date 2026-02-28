module tb_data_transfer_ctrl;
  reg clk, rst_n, start, fifo_empty;
  wire [7:0] fifo_dout;
  wire [7:0] data_out;
  wire read_en, busy, done;
  
  integer error = 0;
  
  data_transfer_ctrl dut(.clk(clk), .rst_n(rst_n), .start(start), .fifo_empty(fifo_empty), .fifo_dout(fifo_dout), .read_en(read_en), .data_out(data_out), .busy(busy), .done(done));
  
  always #5 clk = ~clk;
  
  reg [7:0] model_data;
  
  always @(posedge clk) begin
    if(!rst_n) begin
      fifo_empty <= 1;
    end
    else if(read_en) begin
      fifo_empty <= 1;
    end
  end
  
  assign fifo_dout = model_data;
    
  reg done_seen = 0;
  
  always @(posedge clk) begin
    if(rst_n) begin
      if(done)
        done_seen <= 1;
    end
  end
    
  initial begin
    clk = 0;  rst_n = 0;  start = 0;
    fifo_empty = 1;
    model_data = $random;
    #20;
    rst_n = 1;
    
    fifo_empty = 0;
    @(posedge clk);
    
    @(negedge clk);
    start = 1;
    
    @(negedge clk);
    start = 0;
    
    repeat(5) @(posedge clk);
    
    if(data_out !== model_data) begin
      $display("Data mismatch! Expected=%h Received=%h", model_data, data_out);
      error = error + 1;
    end
      
    if(!done_seen) begin
      $display("DONE never occured");
      error = error + 1;
    end
    
    if(error == 0)
      $display("TEST PASSED");
    else
      $display("TEST FAILED (Errors=%0d)", error);
    $finish;
  end
endmodule