`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/01 17:32:59
// Design Name: 
// Module Name: ifetc32_tb
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


module ifetc32_tb();
reg[31:0]  Addr_result;
reg[31:0]  Read_data_1;
reg Branch;
reg nBranch;
reg Jmp;
reg Jal;
reg Jr;
reg Zero;
reg clock,reset;
wire[31:0] Instruction;             
wire[31:0] branch_base_addr;
wire[31:0] link_addr;

wire[31:0] pco;
     
Ifetc32 Uifetch(.Instruction(Instruction),.branch_base_addr(branch_base_addr),.Addr_result(Addr_result),
        .Read_data_1(Read_data_1),.Branch(Branch),.nBranch(nBranch),.Jmp(Jmp),.Jal(Jal),.Jr(Jr),.Zero(Zero),
        .clock(clock),.reset(reset),.link_addr(link_addr),.pco(pco));
always #2 clock=~clock;
initial 
fork
begin
clock=0;
Addr_result=32'h00000000;
Read_data_1=32'h00000000;
Branch=0;
nBranch=0;
Jmp=0;
Jal=0;
Jr=0;
Zero=0;
reset=1;
end
#8 reset=0;
#22 Jmp=1;
#26 Jmp=0;
#30 Jal=1;
#34 Jal=0;
#38 Addr_result=32'h00000001;
#42 Zero=1;
#42 nBranch=1;
#46 Zero=0;
#46 Addr_result=32'h00000002;
#50
begin
Addr_result=32'h00000001;
Jr=1;
nBranch=0;
Read_data_1=32'h00050007;
end
#54 Read_data_1=32'h00000000;
#54 Jr=0;
#58 Zero=1;
#58 Branch=1;
#64 $finish;
join
endmodule
