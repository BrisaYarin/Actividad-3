`timescale 1ns / 1ps

module subtractor
    #(parameter N=8)
    (
        input logic [N-1:0] a, b,
        output logic [N-1:0] r
    );
    always_comb
        r = a - b;
endmodule