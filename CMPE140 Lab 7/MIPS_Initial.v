
//------------------------------------------------
// Source Code for a Single-cycle MIPS Processor (supports partial instruction)
// Developed by D. Hung, D. Herda and G. Gerken,
// based on the following source code provided by
// David_Harris@hmc.edu (9 November 2005):
//    mipstop.v
//    mipsmem.v
//    mips.v
//    mipsparts.v
//------------------------------------------------

// Main Decoder
module maindec(
	input	[ 5:0]	op, funct,
	output			hilotoreg, regmult, memwrite, branch, alusrc, regwrite, 
	output	[ 1:0]	memtoreg, regdst, jump, aluop );

	reg 	[ 13:0]	controls;

	assign {regwrite, regdst[1], regdst[0], alusrc, branch, memwrite, memtoreg[1], memtoreg[0], jump[1], jump[0], aluop[1], aluop[0], hilotoreg, regmult} = controls;

	always @(*)
		case(op)
			6'b100011: controls <= 14'b10010001000000; //LW
			6'b101011: controls <= 14'b00010100000000; //SW
			6'b000100: controls <= 14'b00001000000100; //BEQ 9'b000100001
			6'b001000: controls <= 14'b10010000000000; //ADDI
			6'b000010: controls <= 14'b00000000010000; //J
			6'b000011: controls <= 14'b11000010010000; //JAL
			6'b000000: case(funct) //SPECIAL CASE
				6'b001000:	controls <= 14'b00000000100000; //JR
				6'b010000:	controls <= 14'b10100000000010; //MFHI
				6'b010010:	controls <= 14'b10100000000000; //MFLO
				6'b011001:	controls <= 14'b00000000000001; //MULTU
				default:	controls <= 14'b10100000001000; //Rtype
			endcase
			default:	controls <= 11'bxxxxxxxxxxx;
		endcase
endmodule

// ALU Decoder
module aludec(
	input		[5:0]	funct,
	input		[1:0]	aluop,
	output reg	[2:0]	alucontrol );

	always @(*)
		case(aluop)
			2'b00: alucontrol <= 3'b010;  // add
			2'b01: alucontrol <= 3'b110;  // sub
			default: case(funct)          // RTYPE
				6'b100000: alucontrol <= 3'b010; // ADD
				6'b100010: alucontrol <= 3'b110; // SUB
				6'b100100: alucontrol <= 3'b000; // AND
				6'b100101: alucontrol <= 3'b001; // OR
				6'b101010: alucontrol <= 3'b111; // SLT
				default:   alucontrol <= 3'bxxx; // ???
			endcase
		endcase
endmodule
// ALU
module alu(
	input		[31:0]	a, b, 
	input		[ 2:0]	alucont, 
	output reg	[31:0]	result,
	output			zero );

	wire	[31:0]	b2, sum, slt;

	assign b2 = alucont[2] ? ~b:b; 
	assign sum = a + b2 + alucont[2];
	assign slt = sum[31];

	always@(*)
		case(alucont[1:0])
			2'b00: result <= a & b;
			2'b01: result <= a | b;
			2'b10: result <= sum;
			2'b11: result <= slt;
		endcase

	assign zero = (result == 32'b0);
endmodule

// Adder
module adder(
	input	[31:0]	a, b,
	output	[31:0]	y );

	assign y = a + b;
endmodule

module multiplier(
	input	[31:0] a, b,
	output	[63:0] y);
	
	assign y = a * b;
endmodule

// Two-bit left shifter
module sl2(
	input	[31:0]	a,
	output	[31:0]	y );

	// shift left by 2
	assign y = {a[29:0], 2'b00};
endmodule

// Sign Extension Unit
module signext(
	input	[15:0]	a,
	output	[31:0]	y );

	assign y = {{16{a[15]}}, a};
endmodule

// Parameterized Register
module flopr #(parameter WIDTH = 8) (
	input					clk, reset,
	input		[WIDTH-1:0]	d, 
	output reg	[WIDTH-1:0]	q);

	always @(posedge clk, posedge reset)
		if (reset) q <= 0;
		else       q <= d;
endmodule

module flopenr #(parameter WIDTH = 8) (
	input					clk, reset,
	input					en,
	input		[WIDTH-1:0]	d, 
	output reg	[WIDTH-1:0]	q);

	always @(posedge clk, posedge reset)
		if      (reset) q <= 0;
		else if (en)    q <= d;
endmodule

// Parameterized 2-to-1 MUX
module mux2 #(parameter WIDTH = 8) (
	input	[WIDTH-1:0]	d0, d1, 
	input				s, 
	output	[WIDTH-1:0]	y );

	assign y = s ? d1 : d0; 
endmodule

// Parameterized 4-to-1 MUX
module mux4 #(parameter WIDTH = 8) (
	input	[WIDTH-1:0]	d0, d1, d2, d3,
	input	[1:0]		s, 
	output reg	[WIDTH-1:0]	y );

	always@(*) 
		case (s)
			2'b01:		y <= d1;
			2'b10:		y <= d2;
			2'b11:		y <= d3;
			default:	y <= d0;
		endcase
	
endmodule

// register file with one write port and three read ports
// the 3rd read port is for prototyping dianosis
module regfile(	
	input			clk, 
	input			we3, 
	input 	[ 4:0]	ra1, ra2, wa3, 
	input	[31:0] 	wd3, 
	output 	[31:0] 	rd1, rd2,
	input	[ 4:0] 	ra4,
	output 	[31:0] 	rd4);

	reg		[31:0]	rf[31:0];
	integer			n;
	
	//initialize registers to all 0s
	initial 
		for (n=0; n<32; n=n+1) 
			rf[n] = 32'h00;
			
	//write first order, include logic to handle special case of $0
    always @(posedge clk)
        if (we3)
			if (~ wa3[4])
				rf[{0,wa3[3:0]}] <= wd3;
			else
				rf[{1,wa3[3:0]}] <= wd3;
		
			// this leads to 72 warnings
			//rf[wa3] <= wd3;
			
			// this leads to 8 warnings
			//if (~ wa3[4])
			//	rf[{0,wa3[3:0]}] <= wd3;
			//else
			//	rf[{1,wa3[3:0]}] <= wd3;
		
	assign rd1 = (ra1 != 0) ? rf[ra1[4:0]] : 0;
	assign rd2 = (ra2 != 0) ? rf[ra2[4:0]] : 0;
	assign rd4 = (ra4 != 0) ? rf[ra4[4:0]] : 0;
endmodule

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
	alu				alu(srca, srcb, alucontrol, aluout, zero);
	
	multiplier		mult(srca, srcb, resultmult);
	flopenr #(64)	hilo(clk, reset, regmult, resultmult, hiloout);
	mux2 #(32)		hilomux(hiloout[31:0], hiloout[63:32], hilotoreg, resulthilo);
	
endmodule

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

// Instruction Memory
module imem (
	input	[ 5:0]	a,
	output 	[31:0]	dOut );
	
	reg		[31:0]	rom[0:63];
	
	//initialize rom from memfile_s.dat
	initial 
		$readmemh("memfile_s.dat", rom);
	
	//simple rom
    assign dOut = rom[a];
endmodule

// Data Memory
module dmem (
	input			clk,
	input			we,
	input	[31:0]	addr,
	input	[31:0]	dIn,
	output 	[31:0]	dOut );
	
	reg		[31:0]	ram[63:0];
	integer			n;
	
	//initialize ram to all FFs
	initial 
		for (n=0; n<64; n=n+1)
			ram[n] = 8'hFF;
		
	assign dOut = ram[addr[31:2]];
				
	always @(posedge clk)
		if (we) 
			ram[addr[31:2]] = dIn; 
endmodule
