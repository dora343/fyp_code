`timescale 1ns / 1ps


module bist_tb(

    );
    reg clock, start;
    wire [4:0] dbg_addr;
    wire [31:0] dbg_data;
    wire reset;
    wire [31:0] default_data_in;
    wire [4:0] default_addr_in;
    wire default_rw_in;
    wire fail;
    always #2 clock = ~clock;
        initial begin
            clock = 0;
            start = 1;
        end
    TOP dut(.start(start), 
            .clock(clock), 
            .reset(reset), 
            .fail(fail), 
            .default_data_in(default_data_in), 
            .default_addr_in(default_addr_in),
            .default_rw_in(default_rw_in),
            .dbg_addr(dbg_addr),
            .dbg_data(dbg_data)
            
    );
endmodule
