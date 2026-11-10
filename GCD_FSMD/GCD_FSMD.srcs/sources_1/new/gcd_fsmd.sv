`timescale 1ns / 1ps

module gcd_fsmd(
    input logic clk,
    input logic clr,
    input logic go,
    input logic [7:0] xin,
    input logic [7:0] yin,
    output logic [7:0] gcd_out
);
    // Señales internas de interconexión (datapath y control)
    logic xsel, ysel, xld, yld, gld;
    logic eqflg, ltflg;
    logic [7:0] xmux_out, ymux_out;
    logic [7:0] xreg_q, yreg_q;
    logic [7:0] xsub_out, ysub_out;

    // Instanciación del Multiplexor para X
    multiplexer x_mux (
        .in_0(xsub_out), 
        .in_1(xin), 
        .sel(xsel), 
        .mux_out(xmux_out)
    );

    // Instanciación del Multiplexor para Y
    multiplexer y_mux (
        .in_0(ysub_out), 
        .in_1(yin), 
        .sel(ysel), 
        .mux_out(ymux_out)
    );

    // Instanciación del Registro X
    register x_reg (
        .clk(clk), 
        .clr(clr), 
        .ld(xld), 
        .d(xmux_out), 
        .q(xreg_q)
    );

    // Instanciación del Registro Y
    register y_reg (
        .clk(clk), 
        .clr(clr), 
        .ld(yld), 
        .d(ymux_out), 
        .q(yreg_q)
    );

    // Instanciación del Restador para X (x = x - y)
    subtractor x_sub (
        .a(xreg_q), 
        .b(yreg_q), 
        .r(xsub_out)
    );

    // Instanciación del Restador para Y (y = y - x)
    subtractor y_sub (
        .a(yreg_q), 
        .b(xreg_q), 
        .r(ysub_out)
    );

    // Instanciación del Comparador
    comparator comp (
        .x(xreg_q), 
        .y(yreg_q), 
        .eqflg(eqflg), 
        .ltflg(ltflg)
    );

    // Instanciación del Registro de Salida (greg)
    register greg (
        .clk(clk), 
        .clr(clr), 
        .ld(gld), 
        .d(xreg_q), 
        .q(gcd_out)
    );

    // Instanciación de la Unidad de Control (FSM)
    control_unit ctrl (
        .clk(clk), 
        .clr(clr), 
        .go(go), 
        .eqflg(eqflg), 
        .ltflg(ltflg),
        .xsel(xsel), 
        .ysel(ysel), 
        .gld(gld), 
        .yld(yld), 
        .xld(xld)
    );

endmodule