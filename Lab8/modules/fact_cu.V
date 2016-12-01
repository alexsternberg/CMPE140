////////////////////////////////////////////////////////////////////////////////
// SubModule CU
// Created   9/7/2016 9:46:32 PM
////////////////////////////////////////////////////////////////////////////////

module fact_cu (GT, GO, CLK, DONE, MUX, REG_LD, CNT_EN, CNT_LD);

input  GT;
input  GO;
input  CLK;
output reg DONE;
output reg MUX;
output reg REG_LD;
output reg CNT_EN;
output reg CNT_LD;

parameter S0 = 1'b0,
          S1 = 1'b1;

reg CS;

initial begin
    CS = 0;
    DONE = 0;
    MUX = 0;
    CNT_LD = 1;
    CNT_EN = 0;
end

always@(posedge CLK)
begin

    case(CS)
         S1: begin
             MUX = 1;
             DONE = ~GT;
             CS = GT;
             CNT_EN = CS;
         end
         default: begin
             DONE = 0;
             CS = GO;
             MUX = 0;
             CNT_EN = 0;
         end
    endcase

REG_LD = 1;
CNT_LD = ~CS;

end



endmodule
////////////////////////////////////////////////////////////////////////////////
