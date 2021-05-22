`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/15 19:45:45
// Design Name: 
// Module Name: cpu
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


module cpu(clk,rst,switch,led,seg_en,seg_out);
input clk,rst;
input [23:0] switch;
output[23:0] led;
output[7:0] seg_en;
output[7:0] seg_out;
wire clock;
wire clk125us;
wire [31:0] address;//dmemory
wire [31:0] writeData;
wire [31:0] readData;
wire [31:0] Instruction;
wire [31:0] ALU_Result;
wire Jr;
wire Jmp;
wire Jal;
wire IORead;
wire IOWrite;
wire MemorIOtoReg;
wire MemRead;
wire Branch;
wire nBranch;
wire RegDST;
wire RegWrite;
wire MemWrite;
wire ALUSrc;
wire I_format;
wire Sftmd;
wire [1:0] ALUOp;
wire [31:0] PC_plus_4;
wire [31:0] opcplus4;
wire [31:0] Addr_result;
wire Zero;
wire [31:0] read_data;
wire [31:0] Read_data_1;
wire [31:0] Read_data_2;
wire [31:0] PC;
wire [31:0] Sign_extend;
wire [15:0] io_rdata;//data read from io -16 bits
wire LEDCtrl;
wire SwitchCtrl;
wire [15:0] switchrdata;
cpuclk u_cpuclk(.clk_in1(clk),.clk_out1(clock));
clk125 u_clk125(.clk(clock),.reset(rst),.clk125us(clk125us));
seg u_seg(.reset(rst),.clock(clk125us),.write(IOWrite),.data_out(writeData),.seg_en(seg_en),.seg_out(seg_out));
ioread u_ioread(.reset(rst),.IORead(IORead),.SwitchCtrl(SwitchCtrl),.switchrdata(switchrdata),.io_rdata(io_rdata));
leds u_leds(.led_clk(clock),.ledrst(rst),.ledwrite(IOWrite),.ledcs(LEDCtrl),
    .ledaddr(address[1:0]),.ledwdata(writeData[15:0]),.ledout(led));
switchs u_switchs(.switclk(clock),.switrst(rst),.switchcs(SwitchCtrl),.switchaddr(address[1:0]),
    .switchread(IORead),.switchrdata(switchrdata),.switch_i(switch));
MemOrIO u_MemOrIO(.mRead(MemRead),.mWrite(MemWrite),.ioRead(IORead),.ioWrite(IOWrite),.addr_in(ALU_Result),
    .addr_out(address),.m_rdata(readData),.io_rdata(io_rdata),.r_wdata(read_data),
    .r_rdata(Read_data_2),.write_data(writeData),.LEDCtrl(LEDCtrl),.SwitchCtrl(SwitchCtrl));
dmemory32 u_dmemory32(.clock(clock),.memWrite(MemWrite),.address(address),.writeData(writeData),.readData(readData));
control32 u_control32(.Opcode(Instruction[31:26]),.Function_opcode(Instruction[5:0]),.Alu_resultHigh(ALU_Result[31:10]),
    .MemorIOtoReg(MemorIOtoReg),.MemRead(MemRead),.IORead(IORead),.IOWrite(IOWrite),.Jr(Jr),
    .Jmp(Jmp),.Jal(Jal),.Branch(Branch),.nBranch(nBranch),.RegDST(RegDST),.RegWrite(RegWrite),.MemWrite(MemWrite),
    .ALUSrc(ALUSrc),.I_format(I_format),.Sftmd(Sftmd),.ALUOp(ALUOp));
Ifetc32 u_Ifetc32(.Instruction(Instruction),.branch_base_addr(PC_plus_4),.link_addr(opcplus4),
    .clock(clock),.reset(rst),.Addr_result(Addr_result),.Zero(Zero),.Read_data_1(Read_data_1),
    .Branch(Branch),.nBranch(nBranch),.Jmp(Jmp),.Jal(Jal),.Jr(Jr),.pco(PC));
Idecode32 u_Idecode32(.Instruction(Instruction),.read_data(read_data),.ALU_result(ALU_Result),.Jal(Jal),
    .RegWrite(RegWrite),.MemtoReg(MemorIOtoReg),.RegDst(RegDST),.clock(clock),.reset(rst),
    .opcplus4(opcplus4),.read_data_1(Read_data_1),.read_data_2(Read_data_2),.imme_extend(Sign_extend));
Executs32 u_Executs32(.Read_data_1(Read_data_1),.Read_data_2(Read_data_2),.Sign_extend(Sign_extend),
    .Function_opcode(Instruction[5:0]),.Opcode(Instruction[31:26]),.Shamt(Instruction[10:6]),.PC_plus_4(PC_plus_4),
    .ALUOp(ALUOp),.ALUSrc(ALUSrc),.I_format(I_format),.Sftmd(Sftmd),.Jr(Jr),.Zero(Zero),.ALU_Result(ALU_Result),.Addr_Result(Addr_result));
endmodule
