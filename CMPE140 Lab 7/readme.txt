Revision of the "MIPS_Single_Implementation.zip" source code,
modified for the Nexys4 DDR board.

- 7-segment displays 7 through 4 show the low 16 bits of the program counter.

- 7-segment displays 3 through 0 show the upper or lower 16 bits of different
  elements as shown below:

DIP switches 7-5 perform the following:

    7:5 = 000 : Display LSW of register selected by DSW 4:0
    7:5 = 001 : Display MSW of register selected by DSW 4:0
    7:5 = 010 : Display LSW of instr
    7:5 = 011 : Display MSW of instr
    7:5 = 100 : DIsplay LSW of dataaddr
    7:5 = 101 : Display MSW of dataaddr
    7:5 = 110 : Display LSW of writedata
    7:5 = 111 : Display MSW of writedata

The bcd_to_7seg, led_mux, and clk_gen utility modules have been updated
for the Nexys 4 DDR board. These differ from the standard utility modules as follows:

- bcd_to_7seg supports hex output, needed to display the MIPS register contents and bus values.

- clk_gen has a 1 second clock instead of 4 seconds.
