`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2020 09:53:37 AM
// Design Name: 
// Module Name: Quad
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


module Quad( pulse,dir, clk, A,B,rst);
input A;
input B;
input clk, rst;
output dir;
output pulse;

reg dir, pulse;

parameter state0 = 0;
parameter state1 = 1;
parameter state2 = 2;
parameter state3 = 3;
reg [1:0] State, NextState;
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
    default: begin
               NextState <= state0;
             end
   endcase
   
end
endmodule