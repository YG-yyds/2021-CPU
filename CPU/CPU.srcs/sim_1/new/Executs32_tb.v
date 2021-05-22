`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/22 15:41:21
// Design Name: 
// Module Name: Executs32_tb
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


module Executs32_tb();
reg [31:0] Read_data_1,Read_data_2,Sign_extend;
reg [5:0] Function_opcode,Opcode;
reg [4:0] Shamt;
reg [31:0] PC_plus_4;
reg [1:0] ALUOp;
reg ALUSrc,I_format,Sftmd,Jr;
wire Zero;
wire [31:0] ALU_Result,Addr_Result;
Executs32 E32(Read_data_1,Read_data_2,Sign_extend,Function_opcode,Opcode,Shamt,PC_plus_4,ALUOp,ALUSrc,I_format,Sftmd,Jr,Zero,ALU_Result,Addr_Result);
initial
begin
begin
Read_data_1=32'hffffffff;
Read_data_2=32'h00000001;
Sign_extend=32'h00000001;
Function_opcode=6'b100000;
Opcode=6'b001000;
ALUOp=2'b10;
Shamt=5'b00000;
Sftmd=1'b0;
Jr=1'b0;
ALUSrc=1'b1;
I_format=1'b1;
PC_plus_4=32'h00000008;
end
end
endmodule
