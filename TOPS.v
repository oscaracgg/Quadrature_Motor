`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2020 09:28:06 AM
// Design Name: 
// Module Name: TOPS
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


module TOP(A,B,rd_en2,wr_en2,out_dir1,out_dir2,out_dir3,out_dir4,din,
 motorPwm1,motorPwm2,motorPwm3,motorPwm4,servoPwm1,servoPwm2,clk,rst,dout);

input din;
input clk,rst;
input [3:0] A,B;

output servoPwm1, servoPwm2;
output out_dir1,out_dir2,out_dir3,out_dir4,motorPwm1,motorPwm2,motorPwm3,motorPwm4;
output dout;
output rd_en2,wr_en2;

wire piso_done;
wire full;
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
wire motor_sig1, motor_sig2, motor_sig3, motor_sig4;
wire servo_en, motor_en,empty, sipo_en,piso_en,sipo_done, rd_en;
wire wr_en2;
wire clk_5mhz;
vehicalProcessor V_P(clk, rst,statusOut, done,DATA, CMD, dir1,dir2,dir3,dir4, 
motorDuty1,motorDuty2,motorDuty3,motorDuty4, servoDuty1,servoDuty2, d_value1,d_value2,d_value3,d_value4, 
speed1,speed2,speed3,speed4, distance1,distance2,distance3,distance4);

quadrature_decode Q_D1(dir1, distance1, speed1, clk,A[0],B[0], rst, d_value1, motor_sig1);
quadrature_decode Q_D2(dir2, distance2, speed2, clk,A[1],B[1], rst,d_value2, motor_sig2);
quadrature_decode Q_D3(dir3, distance3, speed3, clk,A[2],B[2], rst,d_value3, motor_sig3);
quadrature_decode Q_D4(dir4, distance4, speed4, clk,A[3],B[3], rst,d_value4, motor_sig4);

behaviorProcessor B_P(servo_en, motor_en,empty, sipo_en,piso_en,sipo_done, rd_en,clk,rst);

motorPwm motorGen1(motor_en,dir1,out_dir1,clk, rst, motorDuty1, motorPwm1,motor_sig1);

motorPwm motorGen2(motor_en,dir2,out_dir2,clk, rst, motorDuty2, motorPwm2,motor_sig2);

motorPwm motorGen3(motor_en,dir3,out_dir3,clk, rst, motorDuty3, motorPwm3,motor_sig3);

motorPwm motorGen4(motor_en,dir4,out_dir4,clk, rst, motorDuty4, motorPwm4,motor_sig4);

servoPwm servoGen1(servo_en,clk_5mhz, rst, servoDuty1, servoPwm1);

servoPwm servoGen2(servo_en,clk_5mhz, rst, servoDuty2, servoPwm2);

PISO P_S(serial, statusOut, clk,wr_en2,full,piso_en);

SIPO S_P(CMD,DATA, clk, fifo_in, sipo_en, rst, done );
//wr_clk 16mhz
//rd_clk 100mhz
clk_wiz_0 clk_data(.clk_in1(clk),.clk_out1(wr_clk),.reset(rst),.clk_out2(clk_5mhz));

fifo_generator_0 fifoIn(.empty(empty),.din(din),.wr_en(wr_en1),.rd_en(rd_en1),.wr_clk(clk),.rd_clk(wr_clk),.dout(fifo_in));
fifo_generator_0 fifoOut(.full(full),.din(din),.wr_en(wr_en2),.rd_en(rd_en2),.wr_clk(wr_clk),.rd_clk(clk),.dout(dout));
endmodule

