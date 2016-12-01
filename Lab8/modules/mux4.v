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
