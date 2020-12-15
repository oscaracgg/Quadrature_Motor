`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2020 07:53:27 AM
// Design Name: 
// Module Name: TOP
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


module TOP(rd_en2,wr_en2,out_dir1,out_dir2,out_dir3,out_dir4,din, motorPwm1,motorPwm2,motorPwm3,motorPwm4,servoPwm1,servoPwm2,clk,rst,dout);

input din;
input clk,rst;
output servoPwm1, servoPwm2;
output out_dir1,out_dir2,out_dir3,out_dir4,motorPwm1,motorPwm2,motorPwm3,motorPwm4;
output dout;
output rd_en2,wr_en2;

wire sipo_en;
wire piso_done;
wire full;
wire empty;
wire distance1,distance2,distance3,distance4;
wire speed1,speed2,speed3,speed4;
wire [23:0] DATA;
wire [7:0] CMD;
wire done;
wire [23:0] statusOut;
wire [7:0] motorDuty1,motorDuty2,motorDuty3,motorDuty4;
wire  dir1,dir2,dir3,dir4;
wire [23:0] d_value1,d_value2,d_value3,d_value4;
wire [8:0] servoDuty1,servoDuty2;
wire rd_en1;
wire serial;
wire fifo_in;
wire wr_en1;
wire  wr_clk;

vehicalProcessor V_P(clk, rst,statusOut, done,DATA, CMD, dir1,dir2,dir3,dir4, 
motorDuty1,motorDuty2,motorDuty3,motorDuty4, servoDuty1,servoDuty2, d_value1,d_value2,d_value3,d_value4, 
speed1,speed2,speed3,speed4, distance1,distance2,distance3,distance4);


behaviorProcessor B_P(empty, sipo_en,piso_done,done, rd_en1,clk,rst);

motorPwm motorGen1(dir1,out_dir1,clk, rst, motorDuty1, motorPwm1);

motorPwm motorGen2(dir2,out_dir2,clk, rst, motorDuty2, motorPwm2);

motorPwm motorGen3(dir3,out_dir3,clk, rst, motorDuty3, motorPwm3);

motorPwm motorGen4(dir4,out_dir4,clk, rst, motorDuty4, motorPwm4);

servoPwm servoGen1(clk, rst, servoDuty1, servoPwm1);

servoPwm servoGen2(clk, rst, servoDuty2, servoPwm2);

PISO P_S(serial, DATA, clk,wr_en1,full,piso_done,sipo_en);

SIPO S_P(CMD,DATA, clk, fifo_in, sipo_en, rst, done );
//wr_clk 16mhz
//rd_clk 100mhz
clk_wiz_0 clk_data(.clk_in1(clk),.clk_out1(wr_clk),.reset(rst));

fifo_generator_0 fifoIn(.empty(empty),.din(din),.wr_en(wr_en1),.rd_en(rd_en1),.wr_clk(wr_clk),.rd_clk(clk),.dout(fifo_in));
fifo_generator_0 fifoOut(.full(full),.din(din),.wr_en(wr_en2),.rd_en(rd_en2),.wr_clk(clk),.rd_clk(wr_clk),.dout(dout));
endmodule
