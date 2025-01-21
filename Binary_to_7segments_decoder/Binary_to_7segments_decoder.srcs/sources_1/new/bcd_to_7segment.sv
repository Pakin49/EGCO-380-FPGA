`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2025 12:00:05 AM
// Design Name: 
// Module Name: bcd_to_7segment
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


module bcd_to_7segment(
   

    );
endmodule

module segment_a (
   input reg in[3:0],
   output logic out
);
    switch(in)
    case 3`b000 :

    default 
    endcase 

endmodule
   
