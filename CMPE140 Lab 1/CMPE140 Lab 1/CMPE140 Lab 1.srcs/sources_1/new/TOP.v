module TOP(
    input GO, CLK,
    input [31:0] INPUT,
    output [31:0] OUTPUT,
    output DONE
);

wire cnt_ld, cnt_en, reg_ld, mux, gt;

CU              U0(gt, GO, CLK, DONE, mux, reg_ld, cnt_en, cnt_ld);
DP              U1(DONE, INPUT, mux, reg_ld, cnt_en, cnt_ld, gt, OUTPUT, CLK);

endmodule
