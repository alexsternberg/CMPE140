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
				6'b010010:	controls <= 14'b10100011000000; //MFLO
				6'b011001:	controls <= 14'b00000000000001; //MULTU
				default:	controls <= 14'b10100000001000; //Rtype
			endcase
			default:	controls <= 11'bxxxxxxxxxxx;
		endcase
endmodule
