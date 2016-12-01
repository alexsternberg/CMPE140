module fact_ad(
       input we,
       input [1:0] a,
       output reg we1, we2,
       output [1:0] rdsel,
);

case (a)
     2'b01: we1 = 0; we2 = 1;
     2'b10: we1 = 0; we2 = 0;
     2'b11: we1 = 0; we2 = 0;
   default: we1 = 1; we2 = 0;
endcase


assign rdsel = a;

endmodule

