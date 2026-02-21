module tb_fifo;
  parameter DEPTH = 8;
  parameter WIDTH = 8;
  reg clk, rst_n, wr_en, rd_en;
  reg [WIDTH-1:0] din;
  wire [WIDTH-1:0] dout;
  wire full,empty;
  
  fifo #(DEPTH,WIDTH) dut (.clk(clk),.rst_n(rst_n),.wr_en(wr_en),.rd_en(rd_en),.din(din),.dout(dout),.full(full),.empty(empty));
  
  always #5 clk = ~clk;
  
  reg [WIDTH-1:0] model_mem [0:1000];
  integer head=0;
  integer tail=0;
  integer count=0;
  integer error=0;
  
  wire write, read;
  assign read = rd_en && (count > 0);
  assign write = wr_en && ((count < DEPTH) || read);
  
  reg write_d, read_d;
  always @(posedge clk) begin
    write_d <= write;
    read_d <= read;
  end
  
  reg [WIDTH-1:0] din_d;
  always @(posedge clk)
    din_d <= din;
  
  reg reset = 0;
  always @(posedge clk) begin
    if(!rst_n)
      reset <= 0;
    else
      reset <= 1;
  end
  
  always @(posedge clk) begin
    if(reset) begin
      // PUSH
      if(write_d) begin                      
        model_mem[tail] = din_d;
        tail = tail + 1;
        count = count + 1;
      end
      // POP & CHECK
      if(read_d) begin    
        // x DETECTION
        if(^dout === 1'bX) begin               
          $display("x detected at time = %0t , dout = %0d", $time, dout);
          error = error + 1;
        end
        // DATA COMPARISON
        if(model_mem[head] !== dout) begin     
          $display("Data mismatch at time = %0t , expected = %0d , received = %0d", $time, model_mem[head], dout);
          error = error + 1;
        end
        head = head + 1;
        count = count - 1;
      end
      
      // FULL FLAG CHECK
      if((count == DEPTH) != full) begin
        $display("Full flag error at time = %0t", $time);
        error = error + 1;
      end
      
      // EMPTY FLAG CHECK
      if((count == 0) != empty) begin
        $display("Empty flag error at time = %0t", $time);
        error = error + 1;
      end
    end
  end
  
  integer i;
  
  initial begin
    clk = 0;
    rst_n = 0;
    wr_en = 0;
    rd_en = 0;
    din = 0;
    
    repeat(2) @(posedge clk);
    rst_n = 1;
    
    for(i=0 ; i<100 ; i=i+1) begin
      @(posedge clk);
      wr_en = $random % 2;
      rd_en = $random % 2;
      din = $random;
    end
    
    @(posedge clk);
    wr_en = 0;
    rd_en = 0;
    #20;
    
    if(error == 0)
      $display("TEST PASSED");
    else 
      $display("TEST FAILED (Errors = %0d)",error);
    $finish;
  end
endmodule