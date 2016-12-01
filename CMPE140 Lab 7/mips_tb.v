//------------------------------------------------
// mipstest.v
// David_Harris@hmc.edu 23 October 2005
// Testbench for MIPS processor
//------------------------------------------------

module testbench();

  reg         clk;
  reg         reset;

  reg [4:0] switches;
  wire memwrite;
  
  wire	[31:0] 	pc, instr, dataadr, writedata, readdata, dispDat;
  
  // instantiate device to be tested
  mips     mips    (clk, reset, pc, instr, memwrite, dataadr, writedata, readdata, switches[4:0], dispDat);
  imem     imem    (pc[7:2], instr);
  dmem    dmem    (clk, memwrite, dataadr, writedata, readdata);
  
  // initialize test
  initial
    begin
      switches = 5'b00000;
      reset <= 1; # 7; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check that 7 gets written to address 84
  always@(negedge clk)
    begin

    end
endmodule



