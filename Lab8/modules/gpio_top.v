module gpio_top(
	input clk, rst, we,
	input [1:0] a,
	input [31:0] gpi1, gpi2, wd,
	output [31:0] gpo1, gpo2, rd
);
	wire we1, we2;
	wire [1:0] rdsel;
	wire [31:0] 
	
	gpio_ad(we, a, we1, we2, rdsel)
	flopenr reg_gpo1(clk, rst, we1, wd, )

always @ (posedge clk) begin
	
end
