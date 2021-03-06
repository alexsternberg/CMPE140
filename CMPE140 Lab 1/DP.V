////////////////////////////////////////////////////////////////////////////////
// SubModule DP
// Created   9/7/2016 10:47:17 PM
////////////////////////////////////////////////////////////////////////////////

module DP (DONE, INPUT, MUX, REG_LD, CNT_EN, CNT_LD, GT, OUTPUT, CLK);

input  DONE;
input [31:0] INPUT;
input  MUX;
input  REG_LD;
input  CNT_EN;
input  CNT_LD;
output GT;
output [31:0] OUTPUT;
input CLK;

wire [31:0] w1; //Counter to Multiplier, Comparator
wire [31:0] w2; //Multiplier to Mux
wire [31:0] w3; //Mux to Register
wire [31:0] w4; //Register to Multiplier, Buffer

DOWNCOUNTER #(32)   U1(CLK, INPUT, CNT_LD, CNT_EN, w1);
MUL         #(32)   U2(w2, w4, w1);
CMP         #(32)   U3(1, w1, GT);
MUX         #(32)   U4(MUX, 1, w2, w3);
REGISTER    #(32)   U5(REG_LD, CLK, w4, w3);
BUFFER      #(32)   U6(DONE, OUTPUT, w4);

endmodule
////////////////////////////////////////////////////////////////////////////////
