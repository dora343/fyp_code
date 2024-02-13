`timescale 1ns / 1ps

module mux2in1(in1, in2, select, out);
    input in1, in2, select;
    output out;
    
    assign out = select ? in1 : in2 ;
endmodule
