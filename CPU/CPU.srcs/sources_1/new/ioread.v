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
    input IORead;              //  从control32来的I/O读，
    input SwitchCtrl;		//  从memorio经过地址高端线获得的拨码开关模块片选
    input[15:0] switchrdata;  //from switch
    output reg [15:0] io_rdata;	// 将switch的数据送给memorio
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
