`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/20 18:50:22
// Design Name: 
// Module Name: dmemory32
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


module dmemory32(
    input wire clock,
    input wire [0:0] memWrite,
    input wire [31:0] address,
    input wire [31:0] writeData,
    output wire [31:0] readData
    );
    wire clk;
    assign clk=!clock;
    RAM ram(
      .clka(clk),.wea(memWrite),.addra(address[15:2]),
      .dina(writeData),.douta(readData)
    );
endmodule
