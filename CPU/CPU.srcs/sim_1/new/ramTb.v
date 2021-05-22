`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/20 18:51:24
// Design Name: 
// Module Name: ramTb
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


module ramTb();
    reg clock=1'b0;
    reg memWrite=1'b0;
    reg [31:0] addr=32'h00000010;
    reg [31:0] writeData=32'ha0000000;
    wire [31:0] readData;
    dmemory32 uram(clock,memWrite,addr,writeData,readData);
    always
      #50 clock=~clock;
    initial begin
      #200
         writeData=32'ha00000f5;
         memWrite=1'b1;
      #200
         memWrite=1'b0;
     end
endmodule
