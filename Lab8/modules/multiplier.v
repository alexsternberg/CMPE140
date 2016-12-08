module mult(
	input	[31:0] a, b,
	output	[63:0] y,
	output         err);
	
	assign y = a * b;
	assign err = | y[63:32];
endmodule
