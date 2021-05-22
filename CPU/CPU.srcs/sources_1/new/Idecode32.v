`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/04 13:51:56
// Design Name: 
// Module Name: Idecode32
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


module Idecode32(
    input [31:0] Instruction,
    input [31:0] read_data,
    input [31:0] ALU_result,
    input Jal,
    input RegWrite,
    input MemtoReg,
    input RegDst,
    input clock,
    input reset,
    input [31:0] opcplus4,// from ifetch link_address
    output [31:0] read_data_1,
    output [31:0] read_data_2,
    output [31:0] imme_extend
    );
    reg [31:0] register[0:31];//32 register
    reg [4:0] write_register;
    reg [31:0] write_data;
    wire[4:0] read_register_rs;    // rs
    wire[4:0] read_register_rt;     // rt
    wire[4:0] write_register_rd;   // r-form rd
    wire[4:0] write_register_rt;    // i-form rt
    wire[15:0] immediate_value;  // imm
    wire[5:0] Opcode;
    wire sign;
    assign Opcode=Instruction[31:26];
    assign read_register_rs=Instruction[25:21];
    assign read_register_rt=Instruction[20:16];
    assign write_register_rd=Instruction[15:11];
    assign write_register_rt=Instruction[20:16];
    assign immediate_value=Instruction[15:0];
    assign sign=Instruction[15];
    assign imme_extend=(Opcode==6'b001100||Opcode==6'b001101||Opcode==6'b001110||Opcode==6'b001001||Opcode==6'b001011)?
                       {{16{1'b0}},immediate_value}:{{16{sign}},immediate_value};
    assign read_data_1=register[read_register_rs];
    assign read_data_2=register[read_register_rt];
    always@*
    begin
       if(RegWrite==1)
       begin
          if(Opcode==6'b000011 && Jal==1'b1) write_register=5'b11111;//jal $ra
          else if(RegDst==1'b1) write_register=write_register_rd;//r-type
          else write_register=write_register_rt;//i-type
       end
    end
    always@*
    begin
       if (Opcode==6'b000011 && Jal==1'b1) write_data = opcplus4;//jal
       else if(MemtoReg==1'b1)write_data=read_data;
       else write_data=ALU_result;
    end
    integer i;
    always @(posedge clock) 
    begin
       if(reset==1)
       begin              //initialize
          for(i=0;i<32;i=i+1) register[i] <= 0;
       end
       else if(RegWrite==1) 
       begin
          if(RegWrite==1'b1) register[write_register]<=write_data;    
       end
    end
endmodule
