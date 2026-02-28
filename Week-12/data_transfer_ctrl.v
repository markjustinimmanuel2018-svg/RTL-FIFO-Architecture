module data_transfer_ctrl(input clk, rst_n, start, fifo_empty,
                          input [7:0] fifo_dout, output reg read_en,
                          output reg [7:0] data_out, 
                          output reg busy, done);
  
  localparam IDLE=2'b00, READ=2'b01, PROCESS=2'b10, DONE=2'b11;
  
  reg [1:0] state, next_state;
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
      state <= IDLE;
    else
      state <= next_state;
  end
  
  always @(*) begin
    next_state = state;
    case(state)
      IDLE: begin
        if(start && !fifo_empty)
          next_state = READ;
      end
      READ: next_state = PROCESS;
      PROCESS: next_state = DONE;
      DONE: next_state = IDLE;
    endcase
  end
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      read_en <= 0;
      data_out <= 0;
      busy <= 0;
      done <= 0;
    end
    else begin
      read_en <= 0;
      done <= 0;
      case(state)
        IDLE: busy <= 0;
        READ: begin
          busy <= 1;
          read_en <= 1;
        end
        PROCESS: begin
          busy <= 1;
          data_out <= fifo_dout;
        end
        DONE: begin
          busy <= 0;
          done <= 1;
        end
      endcase
    end
  end
endmodule