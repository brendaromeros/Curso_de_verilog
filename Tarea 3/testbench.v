/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    testbench.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 9/06/2024

Descripcion: 
   
*********************************************************** */

`include "controlador.v"
`include "controlador_tester.v"

/* @title Testbench del controlador

Este módulo se encarga de crear una instancia tanto del controlador,
como de las pruebas creadas para la verifi-
cación del correcto funcionamiento del misma.
En caso de que no se compile correctamente, revisar que la dirección
desde donde se incluye el archivo sea la correcta, es decir, 
que la carpeta desde donde se abre la terminal sea la misma donde
están los archivos.*/ 
module testbench;
    wire clk, reset;
    wire [15:0] datain;
    wire [1:0]slave_numb;

controlador dut (
    .clk(clk),
    .reset(reset),
    .datain(datain),
    .slave_numb(slave_numb)
);

controlador_tester tester (
    .clk(clk),
    .reset(reset),
    .datain(datain),
    .slave_numb(slave_numb)
);
initial begin
    $dumpfile("testbench.vcd");
    $dumpvars;
end
endmodule