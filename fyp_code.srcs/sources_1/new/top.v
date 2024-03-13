`timescale 1ns / 1ps

module TOP(start, clock, reset, fail, default_data_in, default_addr_in, default_rw_in, dbg_addr, dbg_data);
    input start, clock, reset;
    output fail;
    input [31:0] default_data_in;
    input [4:0] default_addr_in;
    input default_rw_in;
    output [4:0] dbg_addr;
    output [31:0] dbg_data;
    
    wire [31:0] sram_din;
    wire [4:0] sram_addrin;
    wire sram_rw;
    wire [31:0] sram_qout;
    
    SRAM sram(
        .rst(reset),.clock(clock), .address(sram_addrin), .data(sram_din), .readWriteBar(sram_rw), 
        .q(sram_qout)
    );
    
    BIST bist(
        .start(start), .clock(clock), .reset(reset), 
        .default_data_in(default_data_in), .default_addr_in(default_addr_in), .default_rw_in(default_rw_in),
        .sram_din(sram_din), .sram_addrin(sram_addrin), .sram_rw(sram_rw), .sram_qout(sram_qout), 
        .fail(fail),
        .dbg_addr(dbg_addr), .dbg_data(dbg_data)
    );
endmodule
