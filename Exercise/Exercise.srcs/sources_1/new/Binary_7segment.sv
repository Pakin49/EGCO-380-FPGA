`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2025 10:57:45 AM
// Design Name: 
// Module Name: Binary_7segment
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Binary_7segment(

    );
endmodule

module segment_a(
    input reg[3:0] in,
    output logic out
);

always_comb begin
    case(in)
    2'h00 : out = 1;
    2'h01 : out  =2;
endcase
end
endmodule