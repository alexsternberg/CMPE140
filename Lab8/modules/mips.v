// The MIPS (excluding the instruction and data memories)
module mips(
	input        	clk, reset,
	output	[31:0]	pc,
	input 	[31:0]	instr,
	output			memwrite,
	output	[31:0]	aluout, writedata,
	input 	[31:0]	readdata,
	input	[ 4:0]	dispSel,
	output	[31:0]	dispDat );

	// deleted wire "branch" - not used
	wire 			pcsrc, zero, alusrc, regwrite, hilotoreg, regmult;
	wire	[1:0]	memtoreg, regdst, jump;
	wire	[2:0] 	alucontrol;

	controller c(instr[31:26], instr[5:0], zero, memwrite, pcsrc, alusrc, 
                                regwrite, regmult, hilotoreg, 
                                memtoreg, regdst, jump, alucontrol);
				
	datapath dp(clk, reset, pcsrc, alusrc, 
                                regwrite, regmult, hilotoreg, 
                                regdst, jump, memtoreg, 
                                alucontrol, zero, pc, instr, aluout, 
                                writedata, readdata, dispSel, dispDat); 

endmodule
