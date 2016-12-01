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
