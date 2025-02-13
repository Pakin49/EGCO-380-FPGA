`include "cpu.v"
`include "7seg.v"
`include "bin_to_bcd.v"

module top(
	input CLK,
	input PIN_13,
	output PIN_9,
	output PIN_10, output PIN_11,
	output PIN_12, output PIN_14,
	output PIN_15, output PIN_16,
	output PIN_17, output PIN_18,
	output PIN_19, output PIN_20);

reg[7:0] out;
reg[23:0] clk;
always @(posedge CLK)
	clk <= clk + 1;

cpu cpu0(
	.clk(clk[15]),
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

always @(posedge clk[10])
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

assign {PIN_20, PIN_17, PIN_16, PIN_12} = cathode;

endmodule

