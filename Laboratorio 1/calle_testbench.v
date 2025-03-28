/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    calle_testbench.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 2/04/2024

Descripcion: 
   
*********************************************************** */

`include "calle.v"
`include "calle_tester.v"

/* @title Testbench de la call

Este módulo se encarga de crear una instancia tanto de la
calle, como de las pruebas creadas para la verifi-
cación del correcto funcionamiento de la misma.
En caso de que no se compile correctamente, revisar que la dirección
desde donde se incluye el archivo sea la correcta, es decir, 
que la carpeta desde donde se abre la terminal sea la misma donde
están los archivos.*/ 
module calle_testbench;
    //!Entradas y salidas a utilizar
    wire clk, enb, reset,a_peatonal,b_peatonal;
    wire[1:0]semaforo_a,semaforo_b ;

//! Instancia de la calle
calle DUT(
    .clk(clk), 
    .enb(enb),
    .semaforo_a(semaforo_a),
    .reset(reset),
    .semaforo_b(semaforo_b), 
    .a_peatonal(a_peatonal), 
    .b_peatonal(b_peatonal)
);

//! Instancia de las pruebas realizadas
calle_tester tester(
    .clk(clk), 
    .enb(enb),
    .semaforo_a(semaforo_a),
    .reset(reset),
    .semaforo_b(semaforo_b), 
    .a_peatonal(a_peatonal), 
    .b_peatonal(b_peatonal)
);

/* Para generar las ondas y
y visualizar en gtkwave
*/
initial begin
    $dumpfile("calle_testbench.vcd");
    $dumpvars;
end

endmodule