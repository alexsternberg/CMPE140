module gpio_ad(
    input we,
    input [1:0] a,
    output we1, we2,
    output [1:0] rdsel
);

assign we1 = (a == 2'b10) & we;
assign we2 = (a == 2'b11) & we;
assign rdsel = a;

endmodule

