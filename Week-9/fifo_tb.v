module fifo_tb;
  reg clk, rst_n, wr_en, rd_en;
  reg [7:0] din;
  wire [7:0] dout;
  wire full, empty;
  
  fifo dut (.clk(clk),.rst_n(rst_n),.wr_en(wr_en),.rd_en(rd_en),.din(din),.dout(dout),.full(full),.empty(empty));
  
  always #5 clk=~clk;
  
  integer i;
  
  initial begin
    clk = 0;
    rst_n = 0;
    wr_en = 0;
    rd_en = 0;
    din = 0;
    $monitor("Time = %0t | din = %0h | wr_en = %0b | rd_en = %0b | dout = %0h | FULL = %0b | EMPTY = %0b", $time, din, wr_en, rd_en, dout, full, empty);
    #12 rst_n = 1;
    repeat(2) @(posedge clk);
    for(i=0; i<100; i=i+1) begin
      @(posedge clk);
      wr_en = $random % 2;
      rd_en = $random % 2;
      din = $random;
    end
    @(posedge clk);
    wr_en=0;
    rd_en = 0;
    #20 $finish;
  end
endmodule