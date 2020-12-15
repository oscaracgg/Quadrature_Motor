`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2020 10:29:02 AM
// Design Name: 
// Module Name: PISO
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


module PISO(serial, statusOut, sys_clk,wr_en,full,piso_en);
input [23:0] statusOut;
input sys_clk, full;
output reg serial,wr_en;
output reg piso_en=0;

reg [5:0] count=0;
always @(negedge sys_clk)
begin

if(full)

begin
  wr_en<= 1;
  count<= count+1;
   piso_en <= piso_en;
  if (count == 24)
  begin
    count<= 0;
    piso_en<= ~piso_en;
  end

end



else
wr_en <= 0;


end

always @( count or full)
begin
 if(full)
  serial <= statusOut[count];
 else
   serial <= serial;
end
endmodule