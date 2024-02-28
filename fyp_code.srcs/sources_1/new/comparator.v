`timescale 1ns / 1ps

module comparator(in1, in2, eq, clock);
    input [31:0] in1;
    input [31:0] in2;
    input clock;
    output eq;
    
    reg tmp;
    always @(posedge clock)
    begin
        tmp <= in1 == in2;
    end
    assign eq = tmp;
endmodule
