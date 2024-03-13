`timescale 1ns / 1ps

module counter ( clock, ENABLE, reset, q, cout );

    input clock, ENABLE, reset;
    output [13:0] q;
    output cout;
    
    reg [14:0] cnt_reg;
    reg zero;
    initial zero = 15'b000000000000000;
    initial cnt_reg <= zero;

    always @(posedge reset) begin
        cnt_reg <= zero;
    end

    always @(posedge clock) begin
        if (ENABLE) begin
            cnt_reg <= cnt_reg + 1;
        end
    end

    assign q = cnt_reg[13:0];
    assign cout = cnt_reg[14];

endmodule
