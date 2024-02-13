`timescale 1ns / 1ps

module counter ( clock, ENABLE, reset, q, cout );

    input clock, ENABLE, reset;
    output [11:0] q;
    output cout;
    
    reg [12:0] cnt_reg;
    reg zero;
    initial zero = 8'b 00000000;

    always @(posedge reset) begin
        cnt_reg <= zero;
    end

    always @(posedge clock) begin
        if (ENABLE) begin
            cnt_reg <= cnt_reg + 1;
        end
    end

    assign q = cnt_reg[11:0];
    assign cout = cnt_reg[12];

endmodule
