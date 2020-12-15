`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2020 10:00:11 AM
// Design Name: 
// Module Name: vehicalProcessor
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


module vehicalProcessor(clk, rst,statusOut, sipo_done,DATA, CMD, dir1,
dir2,dir3,dir4, motorDuty1,motorDuty2,motorDuty3,motorDuty4, 
servoDuty1,servoDuty2, d_value1,d_value2,d_value3,d_value4, 
speed1,speed2,speed3,speed4, distance1,distance2,distance3,distance4);
input [23:0] DATA;
input sipo_done;
input clk;
input rst;
input [7:0] CMD;
output reg[7:0] motorDuty1;
output reg [7:0] motorDuty2;
output reg [7:0] motorDuty3;
output reg [7:0] motorDuty4;

output reg dir1;
output reg dir2;
output reg dir3;
output reg dir4;

output reg[8:0] servoDuty1  ;
output reg[8:0] servoDuty2  ;

input [15:0] speed1;
input [15:0] speed2;
input [15:0] speed3;
input [15:0] speed4;

input [23:0] distance1;
input [23:0] distance2;
input [23:0] distance3;
input [23:0] distance4;

output reg[23:0] d_value1;
output reg[23:0] d_value2;
output reg[23:0] d_value3;
output reg[23:0] d_value4;

output reg [23:0] statusOut;



always @(posedge clk)
begin
  if(sipo_done)
  begin
    if (rst)
      statusOut = 0;
      
    case(CMD)
    0: 
         statusOut = 0;
    1:
         //get current distance in pulse counts motor 1
         statusOut<= distance1;
    2:
         //get current distance in pulse counts for motor 2
         statusOut <= distance2;
    3:
         //get current distance in pulse counts motor 3
         statusOut <= distance3;
    4:
         //get current distance inpulse counts motor 4
         statusOut <= distance4;
8'h11:
        //get current velocity in counts for motor 1;
        statusOut <= speed1;
8'h12:
        //get current velocity in counts for motor 1;
        statusOut <= speed2;
8'h13:
        //get current velocity in counts for motor 1;
        statusOut <= speed3;
8'h14:
        //get current velocity in counts for motor 1;
        statusOut <= speed4;
8'h21:
        //get current velocity in counts for motor 1;
        d_value1 <= DATA;
8'h22:
        //get current velocity in counts for motor 1;
        d_value2 <= DATA;
8'h23:
        //get current velocity in counts for motor 1;
        d_value3 <= DATA;
8'h24:
        //get current velocity in counts for motor 1;
        d_value4 <= DATA;
8'h31:begin
        //get current velocity in counts for motor 1;
        motorDuty1 <= DATA[7:0];
        dir1 <= DATA[8];
      end 
8'h32:begin
        //get current velocity in counts for motor 1;
        motorDuty2 <= DATA[7:0];
        dir2 <= DATA[8];
      end
8'h33: begin
        //get current velocity in counts for motor 1;
        motorDuty3 <= DATA[7:0];
        dir3 <= DATA[8];
       end 
8'h34:begin
        //get current velocity in counts for motor 1;
        motorDuty4 <= DATA[7:0];
        dir4 <= DATA[8];
        end
8'h41:begin
        //get current velocity in counts for motor 1;
        servoDuty1 <= DATA[8:0];
        end
8'h42:begin
        //get current velocity in counts for motor 1;
        servoDuty2 <= DATA[7:0];
        end
8'h51:begin
        //get current velocity in counts for motor 1;
        statusOut <= (speed1 + speed3)/2 - (speed2+speed4)/2;
        end
8'h52:begin
        //get current velocity in counts for motor 1;
        statusOut <= (distance1 + distance3)/2 - (distance2+distance4)/2;

        end
8'h61:begin
        //get current velocity in counts for motor 1;
        if (DATA == 24'hAAA)
          statusOut <= 24'h555;
          
        end
8'h62:begin
        //get current velocity in counts for motor 1;
         if (DATA == 24'h555)
          statusOut <= 24'hAAA;
          
        end
    endcase
  end
  else
    statusOut <= 0; 
end
endmodule
