`timescale 1ns / 1ps

module comparator
    #(parameter N=8)
    (
        input logic [N-1:0] x, y,
        output logic eqflg, ltflg
    );
    always_comb
    begin
        eqflg = 1'b0;
        ltflg = 1'b0;
        if (x < y)
            ltflg = 1'b1;
        else if (x == y)
            eqflg = 1'b1;
    end
endmodule