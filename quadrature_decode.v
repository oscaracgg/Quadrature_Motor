`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/14/2020 03:06:58 PM
// Design Name: 
// Module Name: quadrature_decode
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


module quadrature_decode(d_count,counter, pulse,dir, distance, speed, clk, A,B,rst, d_value, motor_sig);
input A;
input B;
input clk, rst;
output dir;
output [23:0] distance;
output [15:0] speed;
output reg motor_sig;
input [23:0] d_value;
output pulse;
output [15:0] counter;
reg [15:0] speed;
reg [23:0] distance = 0;
reg dir, pulse;

parameter state0 = 0;
parameter state1 = 1;
parameter state2 = 2;
parameter state3 = 3;
output reg [1:0] d_count=0;
reg [1:0] State, NextState=0;
reg [15:0] counter=0;
//100mhz
always @(posedge clk)
begin
if (rst)
  State <= 0;
else 
  State <= NextState;
end

always @(A,B,rst,NextState)
begin
   case(State)
   state0: begin
             if(A == 0 && B == 0) begin NextState <= state0; end
               if(A == 0 && B == 1) begin NextState <= state1; pulse <= 0; dir <= 0; end
               if(A == 1 && B == 0) begin NextState <= state3; pulse <= 1; dir <= 1; end
             if(A == 1 && B == 1) begin NextState <= state0; end
          end
   state1: begin 
             if(A == 0 && B == 1) begin NextState <= state1; end
               if( A == 1 && B == 1) begin NextState <= state2; pulse<= 1; dir <= 0; end
               if(A == 0 && B == 0) begin NextState <= state0; pulse <= 0; dir <= 1; end
             if(A == 1 && B == 0) begin NextState <= state1; end
           end
   state2: begin
             if(A == 1 && B ==1) begin NextState <= state2; end
               if(A == 1 && B == 0) begin NextState <= state3; pulse<= 0; dir <= 0; end
               if(A == 0 && B == 1) begin NextState <= state1; pulse <= 1; dir <= 1; end
             if(A == 0 && B ==0) begin NextState <= state2; end
           end
   state3: begin
             if(A == 1 && B == 0) begin NextState<= state3; end
               if(A == 0 && B ==0) begin NextState <= state0; pulse<=1; dir <= 0; end
               if(A == 1 && B ==1) begin NextState<= state2; pulse <= 0; dir <= 1; end
             if(A == 0 && B == 1) begin NextState<= state3; end
           end
   endcase
   
end
reg [1:0] state = 0;

//100mhz
always @(posedge clk, posedge rst)
begin
  if (rst)
  begin
    d_count <= 0;
  end
  
  else
  case(state)
  0:begin
    if(A==1) begin
      state <= 1;
      if(dir == 1)
        distance <= distance+1; 
        
      else
        distance <= distance -1;
      if(d_value == distance)
         motor_sig <= 1;
      else
        motor_sig <= 0;
        
        
                                end
     else begin
       distance <= distance;
       state<= state; end
                                
     end 
  1: begin
     if (A == 0) begin
       state<=0;
       distance <= distance; end
       
       
     
     end
  
  endcase
end
//100mhz
parameter s1 = 1;
parameter s2 = 0;

always @(posedge clk)
//  50,000 max count : 65536 2^16
begin
  if(rst)
  begin
    speed <= 0;
    counter <= 0;
  end
  else
  
    case(pulse)
    0:begin
      if(pulse==0)
       begin
        counter <= 16'h0000;
       end
      end
    1: begin
       
       counter <= counter +1;
       if (counter == 25000)
         speed <= counter;
       else if(counter == 12500)
         speed <= counter;
       end
       
      
    endcase
     
 end     
endmodule

