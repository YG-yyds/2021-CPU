`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/20 21:57:16
// Design Name: 
// Module Name: clk125
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


module clk125(//23MHz->800Hz
    input clk,
    input reset,
    output reg clk125us
    );
    parameter period=28750;
    reg [31:0] cnt;
    always@(posedge clk or posedge reset)
    begin
        if(reset==1)
        begin
            cnt<=0;
            clk125us<=0;
        end
        else
        begin
            if(cnt==(period>>1)-1)
            begin
                clk125us<=~clk125us;
                cnt<=0;
            end
            else
                cnt<=cnt+1;
        end
    end    
endmodule
