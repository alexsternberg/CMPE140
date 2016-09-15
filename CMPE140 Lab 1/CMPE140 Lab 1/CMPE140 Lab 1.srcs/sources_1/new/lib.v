module clk_gen(clk100MHz, rst, clk_4sec, clk_5KHz);
input clk100MHz, rst;
output clk_4sec, clk_5KHz;
reg clk_4sec, clk_5KHz;
integer count, count1;
always@(posedge clk100MHz)
begin
    if(rst)  
    begin
   	 count = 0;   
   	 count1 = 0;
   	 clk_4sec = 0;   
   	 clk_5KHz  =0;
    end  
    else  
    begin
   	 if(count == 200000000)
   	 begin
   		 clk_4sec = ~clk_4sec;    
   		 count = 0;
   	 end
   	 if(count1 == 10000)   
   	 begin
   		 clk_5KHz = ~clk_5KHz;    
   		 count1 = 0;   
   	 end   
   	 count = count + 1;   
   	 count1 = count1 + 1;    	 
    end
 end
endmodule//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////clk_gen     	
module debounce #(parameter width = 16) (
    output reg pb_debounced,
    input wire pb,
    input wire clk
    );

localparam shift_max = (2**width)-1;

reg [width-1:0] shift;

always @ (posedge clk)
begin
    shift[width-2:0] <= shift[width-1:1];
    shift[width-1] <= pb;
    if (shift == shift_max)
   	 pb_debounced <= 1'b1;
    else
   	 pb_debounced <= 1'b0;
end
endmodule//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////debounce


module bcd_to_7seg(
input [3:0] in,
output reg [6:0] out
);

always @ (out) begin
    get_digit(in,out);
end//always

task get_digit;
	input [3:0] A;
	output reg [6:0] s;
    	case (A) // s[0] thru s[6] are active low
        	4'b0000: begin s[0]=0; s[1]=0; s[2]=0; s[3]=1; s[4]=0; s[5]=0; s[6]=0; end
        	4'b0001: begin s[0]=1; s[1]=0; s[2]=1; s[3]=1; s[4]=0; s[5]=1; s[6]=1; end
        	4'b0010: begin s[0]=0; s[1]=1; s[2]=0; s[3]=0; s[4]=0; s[5]=1; s[6]=0; end
        	4'b0011: begin s[0]=0; s[1]=0; s[2]=1; s[3]=0; s[4]=0; s[5]=1; s[6]=0; end
        	4'b0100: begin s[0]=1; s[1]=0; s[2]=1; s[3]=0; s[4]=0; s[5]=0; s[6]=1; end
        	4'b0101: begin s[0]=0; s[1]=0; s[2]=1; s[3]=0; s[4]=1; s[5]=0; s[6]=0; end
        	4'b0110: begin s[0]=0; s[1]=0; s[2]=0; s[3]=0; s[4]=1; s[5]=0; s[6]=0; end
        	4'b0111: begin s[0]=1; s[1]=0; s[2]=1; s[3]=1; s[4]=0; s[5]=1; s[6]=0; end
        	4'b1000: begin s[0]=0; s[1]=0; s[2]=0; s[3]=0; s[4]=0; s[5]=0; s[6]=0; end
        	4'b1001: begin s[0]=0; s[1]=0; s[2]=1; s[3]=0; s[4]=0; s[5]=0; s[6]=0; end
        	default: begin s[0]=1; s[1]=1; s[2]=1; s[3]=1; s[4]=1; s[5]=1; s[6]=1; end
    	endcase
	endtask//task    
endmodule//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////bcd_to_7seg

module led_mux (  
    input wire clk,  
    input wire rst,
    input wire [7:0] LED0, // leftmost digit  
    input wire [7:0] LED1,  
    input wire [7:0] LED2,  
    input wire [7:0] LED3,  
    input wire [7:0] LED4,  
    input wire [7:0] LED5,  
    input wire [7:0] LED6,  
    input wire [7:0] LED7, // rightmost digit  
    output wire [7:0] LEDSEL,  
    output wire [7:0] LEDOUT  
    );   
    
reg [2:0] index;
reg [15:0] led_ctrl;

assign {LEDOUT, LEDSEL} = led_ctrl;

always@(posedge clk)
begin	 
    index <= (rst) ? 3'd0 : (index + 3'd1);
end	 

always @(index, LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7)
begin  
    case(index) 	 
   	 3'd0: led_ctrl <= {8'b11111110, LED7}; 	 
   	 3'd1: led_ctrl <= {8'b11111101, LED6}; 	 
   	 3'd2: led_ctrl <= {8'b11111011, LED5}; 	 
   	 3'd3: led_ctrl <= {8'b11110111, LED4}; 	 
   	 3'd4: led_ctrl <= {8'b11101111, LED3}; 	 
   	 3'd5: led_ctrl <= {8'b11011111, LED2}; 	 
   	 3'd6: led_ctrl <= {8'b10111111, LED1}; 	 
   	 3'd7: led_ctrl <= {8'b01111111, LED0}; 	 
    default: led_ctrl <= {8'b11111111, 8'hFF};	 
endcase
end
endmodule/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////led_mux

module bin2bcd32(
 input wire [31:0] value,
 output wire [3:0] dig0,
 output wire [3:0] dig1,
 output wire [3:0] dig2,
 output wire [3:0] dig3,
 output wire [3:0] dig4,
 output wire [3:0] dig5,
 output wire [3:0] dig6,
 output wire [3:0] dig7
 );

 assign dig0 = value % 10;
 assign dig1 = (value / 10) % 10;
 assign dig2 = (value / 100) % 10;
 assign dig3 = (value / 1000) % 10;
 assign dig4 = (value / 10000) % 10;
 assign dig5 = (value / 100000) % 10;
 assign dig6 = (value / 1000000) % 10;
 assign dig7 = (value / 10000000) % 10;

endmodule 