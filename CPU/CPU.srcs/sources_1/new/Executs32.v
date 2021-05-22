`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/04/21 16:30:06
// Design Name: 
// Module Name: Executs32
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


module Executs32(
    input[31:0] Read_data_1,
    input[31:0] Read_data_2,
    input[31:0] Sign_extend,
    input[5:0] Function_opcode,
    input[5:0] Opcode,
    input[4:0] Shamt,
    input[31:0] PC_plus_4,
    input[1:0] ALUOp,
    input ALUSrc,
    input I_format,
    input Sftmd,
    input Jr,
    output Zero,
    output[31:0] ALU_Result,
    output[31:0] Addr_Result
    );
    wire[31:0] Ainput,Binput;
    wire[5:0] Exe_code;
    wire[2:0] ALU_ctl;
    wire[2:0] Sftm;
    reg [31:0] ALU_output_mux;
    reg [31:0] Shift_Result;
    wire[32:0] Branch_Addr;
    reg [31:0] ALU_Result_reg;
    assign ALU_Result=ALU_Result_reg;
    assign Ainput=Read_data_1;
    assign Binput=(ALUSrc==0)?Read_data_2:Sign_extend[31:0];
    assign Exe_code=(I_format==0)?Function_opcode:{3'b000,Opcode[2:0]};
    assign ALU_ctl[0]=(Exe_code[0]|Exe_code[3])&ALUOp[1];
    assign ALU_ctl[1] = ((!Exe_code[2])|(!ALUOp[1]));
    assign ALU_ctl[2] = (Exe_code[1] & ALUOp[1])|ALUOp[0];
    //shift
    assign Sftm=Function_opcode[2:0];
    always @* 
    begin  
        if(Sftmd)
            case(Sftm[2:0])
                3'b000:Shift_Result = Binput << Shamt;//sll
                3'b010:Shift_Result = Binput >> Shamt;//srl
                3'b100:Shift_Result = Binput << Ainput;//sllv
                3'b110:Shift_Result = Binput >> Ainput;//srlv
                3'b011:Shift_Result = $signed(Binput) >>> Shamt;//sra
                3'b111:Shift_Result = $signed(Binput) >>> Ainput;//srav
                default:Shift_Result = Binput;
            endcase
        else Shift_Result = Binput;
    end
    // ALU_ctrl
    always @(ALU_ctl or Ainput or Binput) 
    begin
        case(ALU_ctl)
            3'b000:ALU_output_mux = Ainput & Binput;//and,andi
            3'b001:ALU_output_mux = Ainput | Binput;//or,ori
            3'b010:ALU_output_mux = Ainput + Binput;//add,addi,lw,sw
            3'b011:ALU_output_mux = Ainput + Binput;//addu,addiu
            3'b100:ALU_output_mux = Ainput ^ Binput;//xor,xori
            3'b101:ALU_output_mux = ~(Ainput | Binput);//nor,lui
            3'b110:ALU_output_mux = Ainput-Binput;//sub,slti,beq,bne
            3'b111:ALU_output_mux = Ainput-Binput;//subu,sltiu,slt,sltu
            default:ALU_output_mux = 32'h00000000;
        endcase
    end
    //get the output of ALU
    always @* 
    begin
        if(((ALU_ctl==3'b111)&&(Exe_code[3]==1))||((ALU_ctl[2:1]==2'b11)&&(I_format==1))) //slt,slti,sltu,sltiu
            ALU_Result_reg =($signed(Ainput)-$signed(Binput)<0)?1:0;
        else if((ALU_ctl==3'b101)&&(I_format==1))
            ALU_Result_reg[31:0] ={{Binput[15:0]},{16{1'b0}}};//lui operation
        else if(Sftmd==1) ALU_Result_reg =Shift_Result;   //shift operation
        else  ALU_Result_reg = ALU_output_mux[31:0];   //other, arithmatic/ logic calculation
    end
    //Addr and PC and Zero
    assign Branch_Addr=PC_plus_4[31:2]+Sign_extend[31:0];
    assign Addr_Result=Branch_Addr[31:0];
    assign Zero=(ALU_output_mux==32'h00000000)?1'b1:1'b0;
endmodule
