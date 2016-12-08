`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2016 06:28:19 PM
// Design Name: 
// Module Name: addrdec
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module addrdec(
    input we,
    input [31:0] a,
    output we1,
    output we2,
    output wem,
    output [1:0] rdsel
    );
            
        assign we1 = we & (a[11:8] == 4'b1000);
        assign we2 = we & (a[11:8] == 4'b1001);
        assign wem = we & !((a[11:8] == 4'b1000) | (a[11:8] == 4'b1001));
        assign rdsel = (a[11:8] == 4'b1000) ? 2'b10 
                     : (a[11:8] == 4'b1001) ? 2'b11 
                     :                        2'b00; 
endmodule
