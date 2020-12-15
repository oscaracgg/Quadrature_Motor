`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2020 11:42:42 AM
// Design Name: 
// Module Name: behaviorProcessor
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


module behaviorProcessor( servo_en, motor_en,empty, sipo_en,piso_en,sipo_done, rd_en,clk,rst);

 input empty;
 output reg rd_en;
 input clk,rst;
 output reg sipo_en;
 input piso_en;
 input sipo_done;
 input servo_en,motor_en;
 
 always @(posedge clk)
 begin
 if(rst)
   begin
     sipo_en <= 0;
     rd_en <= 0;
     
   end
 else
   begin
   if(empty && piso_en || empty && motor_en || empty && servo_en)
     begin
       rd_en <=1;
       sipo_en<=1;
     end
  
     if(sipo_done)begin
       rd_en <= 0;
       sipo_en <=0;
     end 
     
 
     

end 
end 
endmodule
