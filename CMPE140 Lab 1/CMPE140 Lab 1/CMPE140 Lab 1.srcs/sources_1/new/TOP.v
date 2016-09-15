module TOP(
    input GO, CLK,
    input [31:0] INPUT,
    output [31:0] OUTPUT,
    output DONE,
    input clk100MHz, rst, go, pb,
    output err, done,
    output [7:0] LEDOUT, LEDSEL
);

wire clk_5KHz;

wire cnt_ld, cnt_en, reg_ld, mux, gt;

wire [6:0] bcd0, bcd1, bcd2, bcd3, bcd4, bcd5, bcd6, bcd7;
wire [6:0] led0, led1, led2, led3, led4, led5, led6, led7;

CU              U0(gt, GO, CLK, DONE, mux, reg_ld, cnt_en, cnt_ld);
DP              U1(DONE, INPUT, mux, reg_ld, cnt_en, cnt_ld, gt, OUTPUT, CLK);

clk_gen U2 (.clk100MHz(clk100MHz), .rst(rst), .clk_5KHz(clk_5KHz));
debounce U3 (.clk(clk_5KHz), .pb(pb), .pb_debounced(CLK));

bin2bcd32       U4(OUTPUT, bcd0, bcd1, bcd2, bcd3, bcd4, bcd5, bcd6, bcd7);

bcd_to_7seg U5(bcd0, led0);
bcd_to_7seg U6(bcd1, led1);
bcd_to_7seg U7(bcd2, led2);
bcd_to_7seg U8(bcd3, led3);
bcd_to_7seg U9(bcd4, led4);
bcd_to_7seg U10(bcd5, led5);
bcd_to_7seg U11(bcd6, led6);
bcd_to_7seg U12(bcd7, led7);

led_mux U13 (clk_5KHz, rst, led0, led1, led2, led3, led4, led5, led6, led7, LEDOUT, LEDSEL);


endmodule
