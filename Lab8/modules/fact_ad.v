module fact_ad(
       input we,
       input [1:0] a,
       output reg we1, we2,
       output [1:0] rdsel
);

always@(*) 
case (a)
     2'b01: begin we1 = 0; we2 = 1; end
     2'b10: begin we1 = 0; we2 = 0; end
     2'b11: begin we1 = 0; we2 = 0; end
   default: begin we1 = 1; we2 = 0; end
endcase


assign rdsel = a;

endmodule

