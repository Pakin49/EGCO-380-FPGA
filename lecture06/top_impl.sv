`include "cpu.sv"
`include "7seg.sv"
`include "bin_to_bcd.sv"

module top(
	input CLK12MHZ,
	input [0:0] sw,
    output logic [6:0] ja,
    output logic [3:0] jb);

wire CLK;
assign CLK = CLK12MHZ;

logic PIN_13;
assign PIN_13 = sw[0];

logic PIN_11;
assign ja[0] = PIN_11;

logic PIN_9;
assign ja[1] = PIN_9;

logic PIN_15;
assign ja[2] = PIN_15;

logic PIN_18;
assign ja[3] = PIN_18;

logic PIN_19;
assign ja[4] = PIN_19;

logic PIN_10;
assign ja[5] = PIN_10;

logic PIN_14;
assign ja[6] = PIN_14;

logic PIN_20;
assign jb[0] = PIN_20;

logic PIN_17;
assign jb[1] = PIN_17;

logic PIN_16;
assign jb[2] = PIN_16;

logic PIN_12;
assign jb[3] = PIN_12;

reg[7:0] out;
reg[23:0] clk = 0;
always @(posedge CLK)
	clk <= clk + 1;

cpu cpu0(
  .clk(clk[16]), // 16th bit, becomes 1 every 2^17 cycles of CLK
	.reset(PIN_13),
	.out(out));

reg[3:0] cathode = 4'b1110;
reg[6:0] seg_ones;
reg[6:0] seg_tens;
reg[6:0] seg_hundreds;
wire[11:0] bcd;

bin_to_bcd bin_to_bcd0(out, bcd);

seven_seg seven_seg_ones(
	.bcd(bcd[3:0]),
	.segments(seg_ones));

seven_seg seven_seg_tens(
	.bcd(bcd[7:4]),
	.segments(seg_tens));

seven_seg seven_seg_hundreds(
	.bcd(bcd[11:8]),
	.segments(seg_hundreds));

/*
always @(posedge clk[15])
	case (cathode)
		4'b1110: begin
			cathode = 4'b1011;
			{PIN_11, PIN_9, PIN_15, PIN_18, PIN_19, PIN_10, PIN_14} = seg_hundreds;
		end
		4'b1011: begin
			cathode = 4'b1101;
			{PIN_11, PIN_9, PIN_15, PIN_18, PIN_19, PIN_10, PIN_14} = seg_tens;
		end
		4'b1101: begin
			cathode = 4'b1110;
			{PIN_11, PIN_9, PIN_15, PIN_18, PIN_19, PIN_10, PIN_14} = seg_ones;
		end
		default: begin
			cathode = 4'b1111;
		end
	endcase
*/

assign {PIN_20, PIN_17, PIN_16, PIN_12} = ~cathode;
assign {PIN_11, PIN_9, PIN_15, PIN_18, PIN_19, PIN_10, PIN_14} = seg_ones;

endmodule

