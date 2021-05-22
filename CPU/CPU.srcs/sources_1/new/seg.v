`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/20 21:54:43
// Design Name: 
// Module Name: seg
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


module seg(
    input reset,
    input clock,
    input write,
    input [31:0] data_out,
    output reg [7:0] seg_en,
    output reg [7:0] seg_out
    );
    reg [31:0] data;
    wire [3:0] num[0:7];
    reg [2:0] scan_cnt;
    wire [3:0] digit;
    assign digit=num[scan_cnt];
    always @(posedge write)
    begin
       if(write==1'b1) data <= data_out;
       else data <= data;
    end
    assign num[0]=data[3:0];
    assign num[1]=data[7:4];
    assign num[2]=data[11:8];
    assign num[3]=data[15:12];
    assign num[4]=data[19:16];
    assign num[5]=data[23:20];
    assign num[6]=data[27:24];
    assign num[7]=data[31:28];
    always @(posedge clock or posedge reset)
    begin
       if(reset==1) scan_cnt<=0;
       //else if(write) scan_cnt<=0; 
       else begin
          scan_cnt<=scan_cnt+1;
          if(scan_cnt==3'd7) scan_cnt<=0;
       end
    end
    always@*
    begin
       case(digit)
       0: seg_out = 8'b11000000;
       1: seg_out = 8'b11111001;
       2: seg_out = 8'b10100100;
       3: seg_out = 8'b10110000;
       4: seg_out = 8'b10011001;
       5: seg_out = 8'b10010010;
       6: seg_out = 8'b10000010;
       7: seg_out = 8'b11111000; 
       8: seg_out = 8'b10000000;
       9: seg_out = 8'b10010000;
       10:seg_out = 8'b10001000;
       11:seg_out = 8'b10000011;
       12:seg_out = 8'b11000110;
       13:seg_out = 8'b10100001;
       14:seg_out = 8'b10000110;
       15:seg_out = 8'b10001110;
       default seg_out = 8'b11111111;   
       endcase
    end
    always @*
    begin
       case(scan_cnt)
       0: seg_en=8'b11111110;
       1: seg_en=8'b11111101;
       2: seg_en=8'b11111011;
       3: seg_en=8'b11110111;
       4: seg_en=8'b11101111;
       5: seg_en=8'b11011111;
       6: seg_en=8'b10111111;
       7: seg_en=8'b01111111;
       default: seg_en=8'b11111111;
       endcase
    end
endmodule
