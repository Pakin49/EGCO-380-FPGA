module up_down_counter_4bit (
  input CLK12MHZ,
  input [0:0] sw,
  input [1:0] btn,
  output [3:0] led
);
  
  wire rst;
  assign rst = sw[0];
  
  wire clk;
  assign clk = CLK12MHZ;
  
  wire inc_btn;
  assign inc_btn = btn[0];
  
  wire dec_btn;
  assign dec_btn = btn[1];
  
  wire [3:0] count;
  assign led = count;
  
  wire debounced_inc_btn;
  wire debounced_dec_btn;

  debouncer inc_debouncer (
    .clk(clk),
    .rst(rst),
    .btn_in(inc_btn),
    .btn_out(debounced_inc_btn)
  );

  debouncer dec_debouncer (
    .clk(clk),
    .rst(rst),
    .btn_in(dec_btn),
    .btn_out(debounced_dec_btn)
  );


  reg [3:0] count_reg;

  always @(posedge clk) begin
    if (rst) begin
      count_reg <= 4'b0000;
    end else begin
      if (debounced_inc_btn && !debounced_dec_btn) begin
        count_reg <= count_reg + 1;
      end else if (!debounced_inc_btn && debounced_dec_btn) begin
        count_reg <= count_reg - 1;
      end else if (debounced_inc_btn && debounced_dec_btn) begin //Both pressed, maintain the value.
        count_reg <= count_reg;
      end else begin // Neither button pressed, maintain the value.
        count_reg <= count_reg;
      end
    end
  end

  assign count = count_reg;

endmodule