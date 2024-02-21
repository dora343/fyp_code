`timescale 1ns / 1ps

module mux1bits(in1, in2, select, out);
    input in1;
    input in2;
    input select;
    output out;
    
    assign out = select ? in1 : in2 ;
endmodule

