module fifo #(parameter DEPTH =8,
             parameter WIDTH =8
             )(input clk, rst_n, wr_en, rd_en,
               input [WIDTH-1:0] din,
               output reg [WIDTH-1:0] dout,
               output full, empty);
  localparam ADDR_BITS = $clog2(DEPTH);
  
  reg [WIDTH-1:0] mem [0:DEPTH-1];
  reg [ADDR_BITS:0] wr_ptr, rd_ptr;
  
  wire [ADDR_BITS-1:0] wr_addr, rd_addr;
  assign wr_addr = wr_ptr[ADDR_BITS-1:0];
  assign rd_addr = rd_ptr[ADDR_BITS-1:0];
  
  wire wr_wrap, rd_wrap;
  assign wr_wrap = wr_ptr[ADDR_BITS];
  assign rd_wrap = rd_ptr[ADDR_BITS];
  
  wire write, read;
  assign write = wr_en && (!full || read);
  assign read = rd_en && !empty;
  
  assign empty = (wr_ptr == rd_ptr);
  assign full = (wr_addr == rd_addr) && (wr_wrap != rd_wrap);
  
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      wr_ptr <= 0;
      rd_ptr <= 0;
      dout <= 0;
    end
    else begin
      if(write) begin
        mem[wr_addr] <= din;
        wr_ptr <= wr_ptr +1;
      end
      if(read) begin
        dout <= mem[rd_addr];
        rd_ptr <= rd_ptr + 1;
      end
    end
  end
endmodule