////////////////////////////////////////////////////////////////////////////////
// SubModule DP
// Created   9/7/2016 10:47:17 PM
////////////////////////////////////////////////////////////////////////////////

module fact_dp (DONE, INPUT, MUX, REG_LD, CNT_EN, CNT_LD, GT, OUTPUT, CLK, RST, err);

input  DONE;
input [3:0] INPUT;
input  MUX;
input  REG_LD;
input  CNT_EN;
input  CNT_LD;
output GT;
output [31:0] OUTPUT;
input CLK;
input RST;
output err;

wire [3:0] w1; //Counter to Multiplier, Comparator
wire [31:0] w2; //Multiplier to Mux
wire [31:0] w3; //Mux to Register
wire [31:0] w4; //Register to Multiplier, Buffer

downcounter #(4)    U1(CLK, INPUT[3:0], CNT_LD, CNT_EN, w1);
mult                U2({0,w1}, w4, w2, err);
cmp         #(32)   U3(1, {0,w1}, GT);
mux2        #(32)   U4(1,w2,MUX,w3);
flopenr     #(32)   U5(CLK, RST, REG_LD, w3, w4);
buffer      #(32)   U6(w4, DONE, OUTPUT);


endmodule
////////////////////////////////////////////////////////////////////////////////
