module up_down_counter_4bit_tb;
  reg clk;
  reg rst;
  reg inc_btn;
  reg dec_btn;
  wire [3:0] count;
  wire debounced_inc_btn;
  wire debounced_dec_btn;

  up_down_counter_4bit dut (
    .clk(clk),
    .rst(rst),
    .inc_btn(inc_btn),
    .dec_btn(dec_btn),
    .count(count)
  );

  //You can monitor the debounced signals too
  debouncer inc_debouncer_tb (
    .clk(clk),
    .rst(rst),
    .btn_in(inc_btn),
    .btn_out(debounced_inc_btn)
  );

  debouncer dec_debouncer_tb (
    .clk(clk),
    .rst(rst),
    .btn_in(dec_btn),
    .btn_out(debounced_dec_btn)
  );


  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    inc_btn = 0;
    dec_btn = 0;
    #10;
    rst = 0;

    // Example button presses (with bounces)
    inc_btn = 1; #2; inc_btn = 0; #3; inc_btn = 1; #2; inc_btn = 0; #2; inc_btn = 1;
    #10; inc_btn = 0; #100;
    inc_btn = 1; #2; inc_btn = 0; #3; inc_btn = 1; #2; inc_btn = 0; #2; inc_btn = 1;
    #10; inc_btn = 0; #100;

    dec_btn = 1; #2; dec_btn = 0; #3; dec_btn = 1; #2; dec_btn = 0; #2; dec_btn = 1;
    #10; dec_btn = 0; #100;
    dec_btn = 1; #2; dec_btn = 0; #3; dec_btn = 1; #2; dec_btn = 0; #2; dec_btn = 1;
    #10; dec_btn = 0; #100;


    $finish;
  end

  initial begin
    $monitor("Time=%0t, Count=%d, inc_btn=%d, dec_btn=%d, debounced_inc_btn=%d, debounced_dec_btn=%d", $time, count, inc_btn, dec_btn, debounced_inc_btn, debounced_dec_btn);
  end

endmodule