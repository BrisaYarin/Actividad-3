`timescale 1ns / 1ps

module tb_gcd();
    logic clk;
    logic clr;
    logic go;
    logic [7:0] xin;
    logic [7:0] yin;
    logic [7:0] gcd_out;

    // Instanciar el módulo 
    gcd_fsmd uut (
        .clk(clk),
        .clr(clr),
        .go(go),
        .xin(xin),
        .yin(yin),
        .gcd_out(gcd_out)
    );

    // Generador de Reloj (Periodo de 10ns -> 100 MHz)
    always #5 clk = ~clk;

    initial begin
        // Inicializar señales
        clk = 0;
        clr = 1;
        go = 0;
        xin = 0;
        yin = 0;

        // Pulso de Reset
        #20;
        clr = 0;
        #20;

        // --- Caso de Prueba 1: GCD(70, 15) -> Esperado: 5 ---
        xin = 8'd70;
        yin = 8'd15;
        go = 1;         
        #10;
        go = 0;         

        #300;

        // --- Caso de Prueba 2: GCD(48, 18) -> Esperado: 6 ---
        clr = 1;        
        #20;
        clr = 0;
        #20;
        xin = 8'd48;
        yin = 8'd18;
        go = 1;
        #10;
        go = 0;

        #300;
        
        // --- Caso de Prueba 3: GCD(25, 25) -> Esperado: 25 ---
        clr = 1;
        #20;
        clr = 0;
        #20;
        xin = 8'd25;
        yin = 8'd25;
        go = 1;
        #10;
        go = 0;

        #150;
        $stop;
    end
endmodule