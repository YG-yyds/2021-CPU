`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/01 16:17:30
// Design Name: 
// Module Name: IFetc32
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


module Ifetc32(
    output [31:0] Instruction,
    output [31:0] branch_base_addr,
    output [31:0] link_addr,
    input clock,reset,
    //from ALU
    input [31:0] Addr_result,
    input Zero,
    //from Decoder
    input [31:0] Read_data_1,
    //from controller
    input Branch,
    input nBranch,
    input Jmp,
    input Jal,
    input Jr,
    output [31:0] pco
);
    wire[32:0]   PC_plus_4;
    reg [31:0] PC;
    reg [31:0] Next_PC;
    reg [31:0] link_addr_cal;
    assign pco=PC;
    assign link_addr=link_addr_cal;
    assign PC_plus_4[31:2] = PC[31:2] + 1'b1;
    assign PC_plus_4[1:0] =PC[1:0];
    assign branch_base_addr = PC_plus_4[31:0];
    prgrom instmem(.clka(clock),.addra(PC[15:2]),.douta(Instruction));
    always@* 
    begin
    if(((Branch == 1'b1) && (Zero == 1'b1))||((nBranch == 1'b1) && (Zero == 1'b0)))
        Next_PC=Addr_result;
    else if (Jr==1'b1)
        Next_PC=Read_data_1;
    else
        Next_PC=PC_plus_4[31:2];
    end
    always@(negedge clock)
    begin
    if(reset==1'b1) PC<=32'h00000000;
    else if(Jmp == 1'b1 || Jal == 1'b1)
    begin
        //link_addr_cal<=Next_PC;
        PC<={PC[31:28],Instruction[27:0]<<2};
        //PC<={4'b0000,Instruction[25:0],2'b00};
    end
    else PC <= Next_PC<<2;
    end
    always@(posedge Jal)
    begin
        link_addr_cal<=Next_PC;
    end
endmodule
