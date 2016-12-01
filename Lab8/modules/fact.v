module fact(
       input clk, rst, go,
       input [3:0] n,
       output done, err,
       output [31:0] nf,
);


wire cnt_ld, cnt_en, reg_ld, mux, gt;


fact_cu              U0(gt, go, clk, done, mux, reg_ld, cnt_en, cnt_ld);
fact_dp              U1(done, {0,n}, mux, reg_ld, cnt_en, cnt_ld, gt, nf, clk);


endmodule


