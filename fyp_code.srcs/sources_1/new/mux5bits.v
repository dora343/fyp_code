`timescale 1ns / 1ps

module mux5bits(in1, in2, select, out);
    input [4:0] in1;
    input [4:0] in2;
    input select;
    output [4:0] out;
    
    assign out = select ? in1 : in2 ;
endmodule

