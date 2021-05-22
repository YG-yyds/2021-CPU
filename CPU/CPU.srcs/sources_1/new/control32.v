`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/20 21:27:33
// Design Name: 
// Module Name: control32
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


module control32(
    input [5:0] Opcode,
    input [5:0] Function_opcode,
    input [21:0] Alu_resultHigh,
    output MemorIOtoReg,
    output MemRead,
    output IORead,
    output IOWrite,
    output Jr,//1 jr
    output Jmp,//1 j
    output Jal,//1 jal
    output Branch,//1 beq
    output nBranch,//1 bne
    output RegDST,//1 rd, 0 rt
    //output MemtoReg,//1 read data from memory and write it into register
    output RegWrite,//1 write register
    output MemWrite,//1 write data memory
    output ALUSrc,//1 the second operator is immediate except beq,bne
    output I_format,//I-type not beq,bne,lw,sw
    output Sftmd,//shift instruction
    output [1:0] ALUOp
    );
    wire R_format;//1 R type
    wire Lw,Sw;
    assign R_format=(Opcode==6'b000000)?1'b1:1'b0;
    assign I_format=(Opcode[5:3]==3'b001)?1'b1:1'b0;
    assign Lw=(Opcode==6'b100011)?1'b1:1'b0;
    assign Sw=(Opcode == 6'b101011)?1'b1:1'b0;
    assign Jal = (Opcode==6'b000011)? 1'b1:1'b0;
    assign Jr = (Opcode==6'b000000 && Function_opcode == 6'b001000)? 1'b1:1'b0;
    assign Jmp=(Opcode==6'b000010)?1'b1:1'b0;
    assign Branch=(Opcode==6'b000100)?1'b1:1'b0;
    assign nBranch=(Opcode==6'b000101)? 1'b1:1'b0;
    assign RegDST=R_format;
    assign ALUSrc=(I_format||Lw||Sw);
    assign RegWrite=(I_format||Lw||Jal||R_format)&& ~Jr;
    assign Sftmd = (((Function_opcode==6'b000000)||(Function_opcode==6'b000010) 
                   ||(Function_opcode==6'b000011)||(Function_opcode==6'b000100) 
                   ||(Function_opcode==6'b000110)||(Function_opcode==6'b000111))                     
                   && R_format)? 1'b1:1'b0;
    assign ALUOp={(R_format||I_format),(Branch||nBranch)};
    assign MemWrite=(Sw==1'b1&&(Alu_resultHigh[21:0]!=22'h3FFFFF))?1'b1:1'b0;
    //assign MemtoReg=Lw;
    assign MemRead=(Lw==1'b1&&(Alu_resultHigh[21:0]!=22'h3FFFFF))?1'b1:1'b0;
    assign IORead=(Lw==1'b1&&(Alu_resultHigh[21:0]==22'h3FFFFF))?1'b1:1'b0;
    assign IOWrite=(Sw==1'b1&&(Alu_resultHigh[21:0]==22'h3FFFFF))?1'b1:1'b0;
    assign MemorIOtoReg=IORead||MemRead;
endmodule
