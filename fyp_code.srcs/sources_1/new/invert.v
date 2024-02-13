`timescale 1ns / 1ps

module invert(in, out);
    input in;
    output out;
    assign out = ~in;
endmodule
