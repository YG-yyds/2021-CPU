`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/21 15:33:31
// Design Name: 
// Module Name: control32_tb
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


module control32_tb();
reg [5:0] Opcode,Function_opcode;
wire [1:0] ALUOp;
wire Jr,RegDST,ALUSrc,MemtoReg,RegWrite,MemWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd;
control32 c32(Opcode,Function_opcode, Jr,Jmp,Jal,Branch,nBranch, RegDST,MemtoReg,RegWrite,MemWrite, ALUSrc,I_format,Sftmd,ALUOp);
initial 
begin
Opcode = 6'h00;
Function_opcode = 6'h20;
#20
begin
Opcode=6'h00;
Function_opcode = 6'h08;
end
#40
begin
Opcode=6'h08;
Function_opcode = 6'h08;
end
#60
begin
Opcode=6'h23;
Function_opcode = 6'h08;
end
#80
begin
Opcode=6'h2b;
Function_opcode = 6'h08;
end
#105
begin
Opcode=6'h04;
Function_opcode = 6'h08;
end
#125
begin
Opcode=6'h05;
Function_opcode = 6'h08;
end
#150
begin
Opcode=6'h02;
Function_opcode = 6'h08;
end
#170
begin
Opcode=6'h03;
Function_opcode = 6'h08;
end
#195
begin
Opcode=6'h00;
Function_opcode = 6'h02;
end
end
endmodule
