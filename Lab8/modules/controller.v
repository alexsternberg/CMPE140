// Control Unit
module controller(
	input	[5:0]	op, funct,
	input			zero,
	output			memwrite, pcsrc, alusrc, regwrite, regmult, hilotoreg, 
	output	[1:0]	memtoreg, regdst, jump,
	output	[2:0]	alucontrol );

	wire	[1:0]	aluop;
	wire			branch;

	maindec	md(op, funct, hilotoreg, regmult, memwrite, branch, alusrc, regwrite, memtoreg, regdst, jump, aluop);
	aludec	ad(funct, aluop, alucontrol);

	assign pcsrc = branch & zero;
endmodule
