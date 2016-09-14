////////////////////////////////////////////////////////////////////////////////
// SubModule CU
// Created   9/7/2016 9:46:32 PM
////////////////////////////////////////////////////////////////////////////////

module CU (GT, GO, CLK, DONE, MUX, REG_LD, CNT_EN, CNT_LD);

input  GT;
input  GO;
input  CLK;
output reg DONE;
output reg MUX;
output REG_LD;
output CNT_EN;
output CNT_LD;

parameter S0 = 1'b0,
          S1 = 1'b1;

reg CS;

assign {REG_LD, CNT_LD, CNT_EN} =
       CS == S0 ? 3'b110:
                  3'b101;

always@(posedge CLK)
begin
       case(CS)
             S0: begin
                 MUX = 1;
                 DONE = 0;
                 CS = GO ? S1 : S0;
             end
             S1: begin
                 MUX = 0;
                 DONE = GT;
                 CS = GT ? S0 : S1;
             end
       endcase
end


endmodule
////////////////////////////////////////////////////////////////////////////////
