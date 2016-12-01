module srflopr(
       input clk, rst, r, s,
       output reg q,
);

always @ (posedge clk) begin
       if(s)   q = 1;
       if(r)   q = 0;
       if(rst) q = 0;
end

endmodule
