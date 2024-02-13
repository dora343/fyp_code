`timescale 1ns / 1ps



module bist_controller(start, clock, reset, cout, testmode);
    input start, clock, reset, cout;
    output testmode;
    reg state;
    always @(posedge clock) begin
        if (reset)
            state <= 0;
        else 
            if (state)
                if (cout) state <= 0;
                else state <= 1;    
            else
                if (start) state <= 1;         
    end
    
    assign testmode = state;
endmodule
