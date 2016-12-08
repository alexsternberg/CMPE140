// Data Path (excluding the instruction and data memories)
module datapath(
	input			clk, reset, pcsrc, alusrc, regwrite, regmult, hilotoreg,
	input   [1:0]	regdst, jump, memtoreg,
	input	[2:0]	alucontrol,
	output			zero,
	output	[31:0]	pc,
	input	[31:0]	instr,
	output	[31:0]	aluout, writedata,
	input	[31:0]	readdata,
	input	[ 4:0]	dispSel,
	output	[31:0]	dispDat );

	wire [4:0]  	writereg;
	wire [31:0] 	pcnext, pcnextbr, pcplus4, pcbranch, signimm, signimmsh, srca, srcb, result, resulthilo;
	wire [63:0] 	resultmult, hiloout;

	// next PC logic
	flopr #(32) 	pcreg(clk, reset, pcnext, pc);
	adder       	pcadd1(pc, 32'b100, pcplus4);
	sl2         	immsh(signimm, signimmsh);
	adder       	pcadd2(pcplus4, signimmsh, pcbranch);
	mux2 #(32)  	pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
	mux4 #(32)  	pcmux(pcnextbr, {pcplus4[31:28], instr[25:0], 2'b00}, srca, 0, jump, pcnext);

	// register file logic
	regfile			rf(clk, regwrite, instr[25:21], instr[20:16], writereg, result, srca, writedata, dispSel, dispDat);
	mux4 #(5)		wrmux(instr[20:16], instr[15:11], 5'b11111, 5'b00000, regdst, writereg);
	mux4 #(32)		resmux(aluout, readdata, pcplus4, resulthilo, memtoreg, result);
	signext			se(instr[15:0], signimm);

	// ALU logic
	mux2 #(32)		srcbmux(writedata, signimm, alusrc, srcb);
	alu				alu(srca, srcb, instr[10:6], alucontrol, aluout, zero);
	
	mult     		mult(srca, srcb, resultmult);
	flopenr #(64)	hilo(clk, reset, regmult, resultmult, hiloout);
	mux2 #(32)		hilomux(hiloout[31:0], hiloout[63:32], hilotoreg, resulthilo);
	
endmodule
