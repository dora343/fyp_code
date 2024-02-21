`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/02/21 14:28:53
// Design Name: 
// Module Name: SRAM
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


module SRAM (
  input wire [4:0] address,
  input wire [31:0] data,
  input wire readWriteBar,
  output reg [31:0] q
);

  reg [31:0] memory [0:31];

  always @(posedge readWriteBar) begin
    if (readWriteBar) begin
      q <= memory[address];
    end else begin
      memory[address] <= data;
    end
  end
endmodule
