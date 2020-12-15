`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2020 10:10:59 AM
// Design Name: 
// Module Name: SIPO
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


module SIPO(CMD,DATA, sys_clk, din, en_sipo, rst, done );
input sys_clk,din,en_sipo,rst;
output reg[7:0] CMD;
output reg[23:0] DATA;
output reg done;

reg[31:0] ShiftReg_I=32'b0; // shift data using this register then reclock it using module clock when done... 
reg[5:0] BitCount_I=6'b0; // Couter reg to count how many bits have arrived

always @(posedge sys_clk)
begin
  if (rst)
  begin
    BitCount_I <= 0;
    ShiftReg_I <= 0;
  end
  else if(done==1)
    begin
    BitCount_I <= 0;
    
    ShiftReg_I <= 0;
    end
  else 
  begin
    if (en_sipo)
    
      begin
        ShiftReg_I <= {din, ShiftReg_I[31:1]};
        BitCount_I <= BitCount_I +1;
      end
    else
      begin
        ShiftReg_I <= 0;
        BitCount_I <= 0;
      end
  end
  
end

always @(posedge sys_clk)
begin

  if (en_sipo)
    begin
    
    if (rst)
      begin
      DATA<= 0;
      CMD <= 0;
      end
    else
      begin
        if(BitCount_I == 32)
        begin
          DATA <= ShiftReg_I[23:0];
          CMD <= ShiftReg_I[31:24];
          done <= 1;
          
        end
        else
          done <= 0;
      end
    end
    else
      begin

        done <= done;
      end
      
end
endmodule