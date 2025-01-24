module blocking_nonblocking(y,x,clk);

    input x, clk;
    output reg [5:0] y;

    initial y = 6'b000000;

    always @ (posedge clk) begin
        y[0] = x; // assume x = 1
        y[1] = y[0]; // y[1] = 1
        y[2] = y[1]; // y[2] = 1

        y[3] <= x; // assume x = 1
        y[4] <= y[3]; // y[4] = 0
        y[5] <= y[4]; // y[5] = 0
    end
endmodule