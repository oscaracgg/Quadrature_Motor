`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2020 09:33:53 AM
// Design Name: 
// Module Name: servoPwm
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
// 5mhz clk
module servoPwm( servo_en,clk, rst, duty, pwm);

input clk, rst;
input [8:0] duty;
output reg pwm;

output reg servo_en= 0;


reg [13:0] count ;


always @(posedge clk, negedge rst)
begin
  if ( rst)
    count <= 0;
  else 
    begin
      if ( count == 10000) // 5mhz/10000 = 500 hz
        begin              // 2ms
        count <= 0;
        servo_en<= ~servo_en;
        end
      else
        count <= count +1;
        servo_en <= servo_en;
    end
end

always @(count)
begin
  if (count < 5000+duty*9 ) // 2^9 = 512
     pwm <= 0;           // 10,000/512 = 19.5
  else                   // 5000+9*1ff = 9608 4% error
    pwm <= 1;
    
end
endmodule


