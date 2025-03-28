/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    calculadora_testbench.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 2/04/2024

Descripcion: 
   
*********************************************************** 

`include "calculadora_sintesis.v"
`include "cmos_cells_delay.v" */

`include "calculadora.v"
`include "calculadora_tester.v"

/* @title Testbench de la calculadora 

Este módulo se encarga de crear una instancia tanto de la
calculadora, como de las pruebas creadas para la verifi-
cación del correcto funcionamiento de la misma.
En caso de que no se compile correctamente, revisar que la dirección
desde donde se incluye el archivo sea la correcta, es decir, 
que la carpeta desde donde se abre la terminal sea la misma donde
están los archivos.*/ 

module calculadora_testbench;
 //!Entradas y salidas a utilizar
    wire clk,enb,rst;
    wire [1:0]modo;
    wire [7:0] a, b, c;

calculadora DUT(
    .clk(clk),
    .enb(enb),
    .rst(rst),
    .modo(modo[1:0]),
    .a(a[7:0]),
    .b(b[7:0]),
    .c(c[7:0])
);
calculadora_tester pruebas(
    .clk(clk),
    .enb(enb),
    .rst(rst),
    .modo(modo[1:0]),
    .a(a[7:0]),
    .b(b[7:0]),
    .c(c[7:0])
);
    /* Para generar las ondas y
y visualizar en gtkwave
*/
initial begin
    $dumpfile("calculadora_testbench.vcd");
    $dumpvars;
end

endmodule