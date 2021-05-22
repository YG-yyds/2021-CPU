`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/15 19:24:49
// Design Name: 
// Module Name: ioread
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


module ioread(reset,IORead,SwitchCtrl,io_rdata,switchrdata);
    input reset;			 
    input IORead;              //  ��control32����I/O����
    input SwitchCtrl;		//  ��memorio������ַ�߶��߻�õĲ��뿪��ģ��Ƭѡ
    input[15:0] switchrdata;  //from switch
    output reg [15:0] io_rdata;	// ��switch�������͸�memorio
    always @* 
    begin
        if(reset == 1)
            io_rdata = 16'b0000000000000000;
        else if(IORead == 1) begin
            if(SwitchCtrl == 1) io_rdata = switchrdata;
            else io_rdata = io_rdata;
        end
    end
endmodule
