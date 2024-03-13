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
  input wire clock,
  input wire rst,
  input wire [4:0] address,
  input wire [31:0] data,
  input wire readWriteBar,
  output wire [31:0] q
);
  integer i;
  reg [31:0] memory [0:31];
  reg [31:0] out;
  //reg [31:0] reg_d;
initial begin
    out = 32'b00000000000000000000000000000000;
    for (i = 0; i < 6'b100000; i = i + 1) begin
        memory[i] = out;
    end
end


always @(posedge clock) begin
    if (readWriteBar) begin
      out <= memory[address];
    end else begin
    if (address == 4'b00101) begin
      memory[address] <= 32'b00000000000000000000000000000000; 
    end else begin
      memory[address] <= data;
    end
      
    end
end

assign q = out;

endmodule
