`timescale 1ns / 1ps



module bist_controller(start, clock, reset, cout, testmode);
    input start, clock, reset, cout;
    output testmode;
    reg state;
    reg halt;
    initial begin
        state = 0;
        halt = 0;
    end  
    
    always @(posedge clock) begin
        if (reset) begin
            state <= 0;
            halt <= 0;
        end else 
            if (cout) begin
                state <= 0;
                halt <= 1;
            end else if (halt == 0 & start) state <= 1; 
    end
    
    assign testmode = ~halt;
endmodule
