`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/03 20:07:34
// Design Name: 
// Module Name: MemOrIO
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


module MemOrIO(mRead,mWrite,ioRead,ioWrite,addr_in,addr_out,m_rdata,io_rdata,r_wdata,r_rdata,write_data,LEDCtrl,SwitchCtrl);
    //from control32
    input mRead;
    input mWrite;
    input ioRead;
    input ioWrite;
    
    input [31:0] addr_in;//from alu_result in execute32
    output[31:0] addr_out;//address to memory
    input [31:0] m_rdata;//data read from memory
    input [15:0] io_rdata;//data read from io -16 bits
    output[31:0] r_wdata;//data to idecode32 -register file
    input [31:0] r_rdata;//data read from idecode32 write memory or io
    output reg [31:0] write_data;//data to memory or I/O -m_wdata io_wdata
    output LEDCtrl;//LED chip select
    output SwitchCtrl;//switch chip select
    
    assign addr_out=addr_in;
    assign r_wdata = (mRead == 1'b1)?m_rdata:{16'h0000,io_rdata}; 
    assign LEDCtrl=(ioWrite == 1'b1)?1'b1:1'b0;
    assign SwitchCtrl=(ioRead==1'b1)?1'b1:1'b0;
    always @* 
    begin 
        if((mWrite== 1'b1)||(ioWrite==1'b1)) 
            write_data = r_rdata;
        else  
            write_data = 32'hZZZZZZZZ; 
    end 
endmodule
