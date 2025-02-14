module cpu(
	input wire clk,
	input wire reset,
	output reg[7:0] out
	);


///////////////////////////////////////////////////////////////////////////////
// MARK: Opcodes
///////////////////////////////////////////////////////////////////////////////

parameter OP_NOP = 4'b0000; // no op
parameter OP_LDA = 4'b0001; // A < MEM[ADDR]
parameter OP_ADD = 4'b0010; // A < A + MEM[ADDR]
parameter OP_SUB = 4'b0011; // A < A - MEM[ADDR]
parameter OP_STA = 4'b0100; // MEM[ADDR] < A
parameter OP_LDI = 4'b0101; // A < DATA
parameter OP_JMP = 4'b0110; // PC < ADDR
parameter OP_JC  = 4'b0111; // jump if carry
parameter OP_JZ  = 4'b1000; // jump if zero
parameter OP_OUT = 4'b1110; // output to output register
parameter OP_HLT = 4'b1111; // halt


///////////////////////////////////////////////////////////////////////////////
// MARK: Control Signals
///////////////////////////////////////////////////////////////////////////////

// all Control Signals update on the negative edge, prepare the signal first
// Other compoents update on the positive edge

// Halt
reg ctrl_ht;
always @(negedge clk) begin
	if (ir[7:4] == OP_HLT && stage == 2) // Sequence counter = stage 
		ctrl_ht <= 1;
	else
		ctrl_ht <= 0;
end

// Memory Address Register In
reg ctrl_mi;
always @(negedge clk) begin
	if (stage == 0)
		ctrl_mi <= 1;
	else if (ir[7:4] == OP_LDA && stage == 2)
		ctrl_mi <= 1;
	else if (ir[7:4] == OP_ADD && stage == 2)
		ctrl_mi <= 1;
	else if (ir[7:4] == OP_SUB && stage == 2)
		ctrl_mi <= 1;
	else if (ir[7:4] == OP_STA && stage == 2)
		ctrl_mi <= 1;
	else
		ctrl_mi <= 0;
end

// RAM In
reg ctrl_ri;
always @(negedge clk) begin
	if (ir[7:4] == OP_STA && stage == 3)
		ctrl_ri <= 1;
	else
		ctrl_ri <= 0;
end

// RAM Out
reg ctrl_ro;
always @(negedge clk) begin
	if (stage == 1)
		ctrl_ro <= 1;
	else if (ir[7:4] == OP_LDA && stage == 3)
		ctrl_ro <= 1;
	else if (ir[7:4] == OP_ADD && stage == 3)
		ctrl_ro <= 1;
	else if (ir[7:4] == OP_SUB && stage == 3)
		ctrl_ro <= 1;
	else
		ctrl_ro <= 0;
end

// Instruction Register Out
reg ctrl_io;
always @(negedge clk) begin
	if (ir[7:4] == OP_LDA && stage == 2)
		ctrl_io <= 1;
	else if (ir[7:4] == OP_LDI && stage == 2)
		ctrl_io <= 1;
	else if (ir[7:4] == OP_ADD && stage == 2)
		ctrl_io <= 1;
	else if (ir[7:4] == OP_SUB && stage == 2)
		ctrl_io <= 1;
	else if (ir[7:4] == OP_STA && stage == 2)
		ctrl_io <= 1;
	else if (ir[7:4] == OP_JMP && stage == 2)
		ctrl_io <= 1;
	else if (ir[7:4] == OP_JC && stage == 2)
		ctrl_io <= 1;
	else if (ir[7:4] == OP_JZ && stage == 2)
		ctrl_io <= 1;
	else
		ctrl_io <= 0;
end

// Instruction Register In
reg ctrl_ii;
always @(negedge clk) begin
	if (stage == 1)
		ctrl_ii <= 1;
	else
		ctrl_ii <= 0;
end

// A Register In
reg ctrl_ai;
always @(negedge clk) begin
	if (ir[7:4] == OP_LDI && stage == 2)
		ctrl_ai <= 1;
	else if (ir[7:4] == OP_LDA && stage == 3)
		ctrl_ai <= 1;
	else if (ir[7:4] == OP_ADD && stage == 4)
		ctrl_ai <= 1;
	else if (ir[7:4] == OP_SUB && stage == 4)
		ctrl_ai <= 1;
	else
		ctrl_ai <= 0;
end

// A Register Out
reg ctrl_ao;
always @(negedge clk) begin
	if (ir[7:4] == OP_STA && stage == 3)
		ctrl_ao <= 1;
	else if (ir[7:4] == OP_OUT && stage == 2)
		ctrl_ao <= 1;
	else
		ctrl_ao <= 0;
end

// Sum Out
reg ctrl_eo;
always @(negedge clk) begin
	if (ir[7:4] == OP_ADD && stage == 4)
		ctrl_eo <= 1;
	else if (ir[7:4] == OP_SUB && stage == 4)
		ctrl_eo <= 1;
	else
		ctrl_eo <= 0;
end

// Subtract
reg ctrl_su;
always @(negedge clk) begin
	if (ir[7:4] == OP_SUB && stage == 4)
		ctrl_su <= 1;
	else
		ctrl_su <= 0;
end

// B Register In
reg ctrl_bi;
always @(negedge clk) begin
	if (ir[7:4] == OP_ADD && stage == 3)
		ctrl_bi <= 1;
	else if (ir[7:4] == OP_SUB && stage == 3)
		ctrl_bi <= 1;
	else
		ctrl_bi <= 0;
end

// Output Register In
reg ctrl_oi;
always @(negedge clk) begin
	if (ir[7:4] == OP_OUT && stage == 2)
		ctrl_oi <= 1;
	else
		ctrl_oi <= 0;
end

// Counter Enable
reg ctrl_ce;
always @(negedge clk) begin
	if (stage == 1)
		ctrl_ce <= 1;
	else
		ctrl_ce <= 0;
end

// Counter Out
reg ctrl_co;
always @(negedge clk) begin
	// Always in Stage 0
	if (stage == 0)
		ctrl_co <= 1;
	else
		ctrl_co <= 0;
end

// Jump
reg ctrl_jp;
always @(negedge clk) begin
	if (ir[7:4] == OP_JMP && stage == 2)
		ctrl_jp <= 1;
	else if (ir[7:4] == OP_JC && stage == 2 && flags[FLAG_C] == 1)
		ctrl_jp <= 1;
	else if (ir[7:4] == OP_JZ && stage == 2 && flags[FLAG_Z] == 1)
		ctrl_jp <= 1;
	else
		ctrl_jp <= 0;
end

// Flags Register In
reg ctrl_fi;
always @(negedge clk) begin
	if (ir[7:4] == OP_ADD && stage == 4)
		ctrl_fi <= 1;
	else if (ir[7:4] == OP_SUB && stage == 4)
		ctrl_fi <= 1;
	else
		ctrl_fi <= 0;
end


///////////////////////////////////////////////////////////////////////////////
// MARK: Bus
///////////////////////////////////////////////////////////////////////////////

wire[7:0] bus;
assign bus =
	ctrl_co ? pc :
	ctrl_ro ? mem[mar] :
	ctrl_io ? ir[3:0] :
	ctrl_ao ? a_reg :
	ctrl_eo ? alu :
	8'b0;


///////////////////////////////////////////////////////////////////////////////
// MARK: Program Counter
///////////////////////////////////////////////////////////////////////////////

reg[3:0] pc;
always @(posedge clk or posedge reset) begin
	if (reset)
		pc <= 0;
	else if (ctrl_ce)
		pc <= pc + 1;
	else if (ctrl_jp)
		pc <= bus[3:0];
end


///////////////////////////////////////////////////////////////////////////////
// MARK: Instruction Step Counter
///////////////////////////////////////////////////////////////////////////////

reg[2:0] stage;
always @(posedge clk or posedge reset) begin
	if (reset)
		stage <= 0;
	else if (stage == 5 || ctrl_jp)
		stage <= 0;
	else if (ctrl_ht || stage == 6)
		// For a halt, put it into a stage it can never get out of
		stage <= 6;
	else
		stage <= stage + 1;
end


///////////////////////////////////////////////////////////////////////////////
// MARK: Memory Address Register
///////////////////////////////////////////////////////////////////////////////

// 16 bytes ram so only 4 bits for address
reg[3:0] mar;
always @(posedge clk or posedge reset) begin
	if (reset)
		mar <= 0;
	else if (ctrl_mi)
		mar <= bus[3:0];
end


///////////////////////////////////////////////////////////////////////////////
// MARK: Memory
///////////////////////////////////////////////////////////////////////////////

reg[7:0] mem[16];
always @(posedge clk) begin
	if (ctrl_ri)
		mem[mar] <= bus;
end


///////////////////////////////////////////////////////////////////////////////
// MARK: Instruction Register
///////////////////////////////////////////////////////////////////////////////

reg[7:0] ir;
always @(posedge clk or posedge reset) begin
	if (reset)
		ir <= 0;
	else if (ctrl_ii)
		ir <= bus;
end


///////////////////////////////////////////////////////////////////////////////
// MARK: ALU
///////////////////////////////////////////////////////////////////////////////

reg[7:0] a_reg;
reg[7:0] b_reg;
wire[7:0] b_reg_out;
wire[8:0] alu;
wire flag_z, flag_c;
always @(posedge clk or posedge reset) begin
	if (reset)
		a_reg <= 0;
	else if (ctrl_ai)
		a_reg <= bus;
end

always @(posedge clk or posedge reset) begin
	if (reset)
		b_reg <= 0;
	else if (ctrl_bi)
		b_reg <= bus;
end

// Zero flag is set if ALU is zero
assign flag_z = (alu[7:0] == 0) ? 1 : 0;

// Use twos-complement for subtraction
assign b_reg_out = ctrl_su ? ~b_reg + 1 : b_reg;

// Carry flag is set if there's an overflow into bit 8 of the ALU
assign flag_c = alu[8];

assign alu = a_reg + b_reg_out;


///////////////////////////////////////////////////////////////////////////////
// MARK: Flags Register
///////////////////////////////////////////////////////////////////////////////

parameter FLAG_C = 1;
parameter FLAG_Z = 0;

reg[1:0] flags;
always @(posedge clk or posedge reset) begin
	if (reset)
		flags <= 0;
	else if (ctrl_fi)
		flags <= {flag_c, flag_z};
end


///////////////////////////////////////////////////////////////////////////////
// MARK: Output Register
///////////////////////////////////////////////////////////////////////////////

always @(posedge clk or posedge reset) begin
	if (reset)
		out <= 0;
	else if (ctrl_oi)
		out <= bus;
end


///////////////////////////////////////////////////////////////////////////////
// MARK: Program to Run
///////////////////////////////////////////////////////////////////////////////

initial begin
	mem[0]  = {OP_OUT, 4'b0}; // output A to output register (the lower 4 bits is padding, the value always comes from A)
	mem[1]  = {OP_ADD, 4'hF}; // add mem[15] to A (A + 1 since the value at mem[15] is 1), A is zero after reset
	mem[2]  = {OP_JC,  4'h4}; // jump to 4 if carry (A = 256)
	mem[3]  = {OP_JMP, 4'h0}; // jump to 0
	mem[4]  = {OP_SUB, 4'hF}; // subtract mem[15] from A (A - 1 since the value at mem[15] is 1)
	mem[5]  = {OP_OUT, 4'h0}; // output A to output register
	mem[6]  = {OP_JZ,  4'h0}; // jump to 0 if zero
	mem[7]  = {OP_JMP, 4'h4}; // jump to 4
	mem[8]  = {OP_NOP, 4'h0};
	mem[9]  = {OP_NOP, 4'h0};
	mem[10] = {OP_NOP, 4'h0};
	mem[11] = {OP_NOP, 4'h0};
	mem[12] = {OP_NOP, 4'h0};
	mem[13] = {OP_NOP, 4'h0};
	mem[14] = {OP_NOP, 4'h0};
	mem[15] = {8'h01};        // DATA = 1
end

endmodule