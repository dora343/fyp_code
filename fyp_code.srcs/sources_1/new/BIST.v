`timescale 1ns / 1ps

module BIST(start, clock, reset, fail, default_data_in, default_addr_in, default_rw_in, sram_din, sram_addrin, sram_rw, sram_qout, dbg_addr, dbg_data);
    input start, clock, reset;
    input [31:0] default_data_in;
    input [4:0] default_addr_in;
    input default_rw_in;
    input [31:0] sram_qout;
    output [31:0] sram_din;
    output [4:0] sram_addrin;
    output sram_rw;
    output fail;
    output [4:0] dbg_addr;
    output [31:0] dbg_data;
    
    //wire [4:0]address;
    reg halt;
    reg [4:0] last_addr;
    wire [13:0] Q;
    wire [4:0] addr_in;
    wire [31:0] data_in;
    wire cout, testmode, eq;
    wire [31:0] true_data;
    wire MUX_RW_SELECT;
    wire test_rw_in;
    wire rw_in;
    wire bist_rw_in;
    initial begin
        halt = 0;
        last_addr = 5'b00000;
    end

    always @(Q[3]) begin
        last_addr = Q[7:3];   
    end
    always @(posedge Q[1]) begin
        if (rw_in & ~eq) begin
            halt <= 1;
        end else begin
            halt <= cout;
        end    
    
    end
    counter CNT (
        .clock(clock), .ENABLE(testmode), .reset(reset), 
        .q(Q), .cout(cout)
    );   
    decoder DEC (
        .in(Q[13:10]), 
        .out(true_data)
    );    
    bist_controller BIST_CTRL (
        .start(start), .clock(clock), .reset(reset), .cout(halt), 
        .testmode(testmode)
    ); 
    mux5bits MUX_ADDR (  
        .in1(Q[7:3]), .in2(default_addr_in), .select(testmode), 
        .out(addr_in)
    );    
    mux32bits MUX_DATA (
        .in1(true_data), .in2(default_data_in), .select(testmode), 
        .out(data_in)
    );    
    xnor_gate X (
        .in1(Q[8]), .in2(Q[9]), 
        .out(MUX_RW_SELECT)
    );    
    invert INV (
        .in(Q[2]), 
        .out(test_rw_in)
    );
    mux1bits MUX_RW (
        .in1(Q[9]), .in2(test_rw_in), .select(MUX_RW_SELECT), 
        .out(bist_rw_in)
    );   
    mux1bits MUX_RW2 (
        .in1(bist_rw_in), .in2(default_rw_in), .select(testmode),
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
    assign fail = halt;
    assign dbg_addr = last_addr;
    assign dbg_data = true_data;
    
endmodule
