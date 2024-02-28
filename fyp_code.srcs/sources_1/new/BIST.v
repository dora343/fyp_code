`timescale 1ns / 1ps

module BIST(start, clock, reset, fail, default_data_in, default_addr_in,  sram_din, sram_addrin, sram_rw, sram_qout);
    input start, clock, reset;
    input [31:0] default_data_in;
    input [4:0] default_addr_in;
    input [31:0] sram_qout;
    output [31:0] sram_din;
    output [4:0] sram_addrin;
    output sram_rw;
    output fail;
    
    //wire [4:0]address;
    //changed
    wire [11:0] Q;
    wire [4:0] addr_in;
    wire [31:0] data_in;
    wire cout, testmode, eq;
    wire [31:0] true_data;
    wire MUX_RW_SELECT;
    wire test_rw_in;
    wire rw_in;
    
    counter CNT (
        .clock(clock), .ENABLE(testmode), .reset(reset), 
        .q(Q), .cout(cout)
    );   
    decoder DEC (
        .in(Q[11:8]), 
        .out(true_data)
    );    
    bist_controller BIST_CTRL (
        .start(start), .clock(clock), .reset(reset),
        .cout(cout), .testmode(testmode)
    ); 
    mux5bits MUX_ADDR (  
        .in1(Q[5:1]), .in2(default_addr_in), .select(testmode), 
        .out(addr_in)
    );    
    mux32bits MUX_DATA (
        .in1(true_data), .in2(default_data_in), .select(testmode), 
        .out(data_in)
    );    
    xnor_gate X (
        .in1(Q[6]), .in2(Q[7]), 
        .out(MUX_RW_SELECT)
    );    
    invert INV (
        .in(Q[0]), 
        .out(test_rw_in)
    );
    mux1bits MUX_RW (
        .in1(Q[7]), .in2(test_rw_in), .select(MUX_RW_SELECT), 
        .out(rw_in)
    );    
    comparator CMP (
        .clock(clock), 
        .in1(true_data), .in2(sram_qout),
        .eq(eq)
    );

    assign sram_addrin = addr_in;
    assign sram_din = data_in;
    assign sram_rw = rw_in;
    assign fail = (~(Q[6]&Q[7])) ? 0 :~eq;
    
endmodule
