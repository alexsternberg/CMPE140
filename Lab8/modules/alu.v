// ALU
module alu(
	input		[31:0]	a, b, 
	input       [ 4:0]  shamt,
	input		[ 2:0]	alucont, 
	output reg	[31:0]	result,
	output			zero );

	wire	[31:0]	b2, sum, slt;

	assign b2 = alucont[2] ? ~b:b; 
	assign sum = a + b2 + alucont[2];
	assign slt = sum[31];

	always@(*)
		case(alucont[2:0])
			3'b000: result <= a & b;
			3'b001: result <= a | b;
			3'b010: result <= sum; // add
			3'b110: result <= sum; // sub
			3'b100: result <= b << shamt; //sll
			3'b101: result <= b >> shamt; //slr
			3'b011: result <= slt;
			
		endcase

	assign zero = (result == 32'b0);
endmodule
