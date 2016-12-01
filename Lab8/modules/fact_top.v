module fact_top(
       input clk, rst, we,
       input [1:0] a,
       input [3:0] wd,
       output [31:0] rd,
);

wire go, go_pulse, go_pulse_cmb, done, err, we1, we2, res_done, res_err;
wire [3:0] n;
wire [31:0] result;

fact_ad       U0();
fact          U1(clk, rst, go_pulse, wd, done, err, rd);
flopenr       U2(clk, rst, we1, wd, n);
flopenr       U3(clk, rst, we2, wd[0], go);
flopr         U4(clk, rst, go_pulse_cmb, go_pulse);
srflopr       U5(clk, rst, done, go_pulse_cmb, res_done);
srflopr       U6(clk, rst, err, go_pulse_cmb, res_err);
mux4          U7({0, n}, {0, go}, {0, res_err, res_done}, result, rdsel, rd);

assign go_pulse_cmb = wd[0] & we2;

endmodule

