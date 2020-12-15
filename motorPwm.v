`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2020 09:33:30 AM
// Design Name: 
// Module Name: motorPwm
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

//100mhz clk
module motorPwm(motor_en,dir,out_dir,clk, rst, duty, pwm, mclk,motor_sig);
input clk, rst,motor_sig;
input [7:0] duty;
output reg pwm;
output reg mclk = 0;
input dir;
output reg out_dir;

reg [12:0] count =0;
output reg motor_en = 0;

always @(posedge clk, negedge rst)
begin
  if (rst)
    count <= 0;
  else 
    begin
      if ( count == 3120) //100mhz/3120 = 32khz
        begin
        count <= 0;
        motor_en<=~motor_en;
        out_dir <= dir;
        end
      else
        motor_en<=motor_en;
        count <= count +1;
      
    end
end

always @(count or duty) //8bit duty = 256
                                 //3120/256 = 12 
begin                            //ff*12 = 3100
  if (count < duty*12 || motor_sig==1 )
     pwm <= 0;
  else
    pwm <= 1;
    
end

endmodule

