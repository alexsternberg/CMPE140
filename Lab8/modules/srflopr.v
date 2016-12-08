module srflopr(
       input clk, rst, s, r,
       output reg q
);

initial q = 0;

always @ (posedge clk) begin
       if(s)   q = 1;
       if(r)   q = 0;
       if(rst) q = 0;
end

endmodule
