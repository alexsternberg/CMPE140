module gpio_top(
    input clk, rst, we,
    input [1:0] a,
    input [31:0] gpi1, gpi2, wd,
    output [31:0] gpo1, gpo2, rd
);
    wire we1, we2;
    wire [1:0] rdsel;


    gpio_ad          gpiodec(we, a, we1, we2, rdsel);
    flopenr  #(32)  reg_gpo1(clk, rst, we1, wd, gpo1);
    flopenr  #(32)  reg_gpo2(clk, rst, we2, wd, gpo2);
    mux4     #(32)       out(gpi1, gpi2, gpo1, gpo2, rdsel, rd);

endmodule
