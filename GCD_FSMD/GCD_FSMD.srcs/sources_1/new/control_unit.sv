`timescale 1ns / 1ps

module control_unit(
    input logic clk, clr, go, eqflg, ltflg,
    output logic xsel, ysel, gld, yld, xld
);
    
    typedef enum {start, _input, test1, done, test2, y_x, x_y} state_type;
    state_type state_reg, state_next;
    
    always_ff @(posedge clk, posedge clr)
        if(clr)
            state_reg <= start; 
        else
            state_reg <= state_next;

    always_comb
    begin
        state_next = state_reg;
        xsel = 1'b0;
        ysel = 1'b0;
        xld  = 1'b0;
        yld  = 1'b0;
        gld  = 1'b0;
        case(state_reg)
            start:
                if(~go)
                    state_next = start;
                else
                    state_next = _input;
            _input:
                begin
                    xsel = 1'b1;
                    ysel = 1'b1;
                    xld  = 1'b1;
                    yld  = 1'b1;
                    state_next = test1;
                end
            test1:
                if(~eqflg)
                    state_next = test2;
                else
                    state_next = done;
            test2:
                if (~ltflg)
                    state_next = x_y;
                else
                    state_next = y_x;
            y_x:
                begin
                    yld  = 1'b1;
                    ysel = 1'b0;
                    state_next = test1;
                end
            x_y:
                begin
                    xld  = 1'b1;
                    xsel = 1'b0;
                    state_next = test1;
                end
            done:
                begin 
                    gld = 1'b1;
                    state_next = done;
                end
            default: state_next = start;
        endcase
    end
endmodule