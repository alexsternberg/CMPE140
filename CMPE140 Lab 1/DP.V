module DP(
        input clk, rst,
        input [3:0] did,
        input [3:0] dir,
        input [3:0] n,
        output [4:0] rem,
        output [3:0] quo,
        output [3:0] cnt,
        output lt,
        output error_int,
        input s1,
        input shr_r, shl_r, ld_r,
        input shr_x, shl_x, inr_x, ld_x,
        input shr_y, shl_y, ld_y,
        input s2, s3, cnt_en, cnt_ld, cnt_ud
    );
    wire [4:0] w1; //sub to MUX_IN
    wire [4:0] w2; //MUX_IN to R_SR
    wire [4:0] w3; //R_SR to output MUX_R
    wire [3:0] w4; //X_SR to output MUX_Q
    wire [3:0] w5; // Y_SR to places

    assign error_int = !dir ? 1: 0;

    mux2 #(5)           m1(s1, w1, 5'b00000, w2);
    SR #(5)             r(1'b0, w4[3], w2, ld_r, shr_r, shl_r,  rst, clk, w3);
    SR                  x(1'b0, inr_x, did, ld_x,  shr_x, shl_x, rst, clk, w4);
    SR                  y(1'b0, 1'b0, dir, ld_y, shr_y, shl_y, rst, clk, w5);
    comp #(4)           comp(w3[3:0], w5, lt);
    sub                 sub(w3[3:0], w5, w1);
    mux2                m2(s2, w3, 5'b00000, rem);
    mux2                m3(s3, w4, 4'b0000, quo);
    ud_counter          c(n, rst, cnt_en, cnt_ld, cnt_ud, clk, cnt);
endmodule/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////DP
















