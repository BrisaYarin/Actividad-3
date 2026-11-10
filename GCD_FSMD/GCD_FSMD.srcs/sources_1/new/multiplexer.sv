`timescale 1ns / 1ps

module multiplexer(
    input logic [7:0] in_0, in_1,
    input logic sel,
    output logic [7:0] mux_out
);
    always_comb
        if (~sel)
            mux_out = in_0;
        else
            mux_out = in_1;
endmodule