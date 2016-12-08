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
  wire rst;
  
  assign rst = reset;
  
  wire	[31:0] 	pc, instr, dataadr, writedata, readdata, dispDat;
  
  // instantiate device to be tested
  mips     mips    (clk, reset, pc, instr, memwrite, dataadr, writedata, readdata, switches[4:0], dispDat);
  imem     imem    (pc[7:2], instr);

  wire fact_we, mem_we, gpio_we;
  wire [1:0] rdsel;
  wire [31:0] fact_mux, mem_mux, gpio_mux, gpo1, gpo2;
  
  reg [31:0] gpi1, gpi2;

  addrdec     dec     (memwrite, dataadr, fact_we, gpio_we, mem_we, rdsel);
  mux4   #32  mux     (mem_mux,mem_mux,fact_mux,gpio_mux,rdsel, readdata);
  gpio_top    gpio    (clk, rst, gpio_we, dataadr[3:2], gpi1, gpi2, writedata, gpo1, gpo2, gpio_mux);
  fact_top    fact    (clk, rst, fact_we, dataadr[3:2], writedata[3:0], fact_mux);
  
  dmem     dmem    (clk, memwrite, dataadr, writedata, mem_mux);
  
  // initialize test
  initial
    begin
      switches = 5'b00000;
      reset <= 1; # 7; reset <= 0;    
      gpi1 = 4  ;
      gpi2 = 1;
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



