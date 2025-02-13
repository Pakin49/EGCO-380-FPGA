module my_dff(input DFF_CLOCK, rst, D, output reg Q);
    always @ (posedge DFF_CLOCK) begin
        if (rst) begin
          Q <= 1'b0;
        end
        else begin
          Q <= D;
        end
    end
endmodule