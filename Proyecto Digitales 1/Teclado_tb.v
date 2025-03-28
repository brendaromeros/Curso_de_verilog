/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0323
                   Circuitos Digitales 1

                    Teclado_tb.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>
        Alejandra Solano Ramírez <mariaalejandra.solano@ucr.ac.cr>
        Jun Hyun Yeom Song <jun.yeom@ucr.ac.cr>

Fecha: 27/02/2024

Descripción: 
    Contiene el módulo que se encarga de realizar las pruebas 
con el teclado creado del archivo Teclado.v con las pruebas del
archivo Teclado_Tests.v para verificar que todo funciona correctamente.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */


`include "Teclado.v"
`include "Teclado_Tests.v"

/* @title Testbench del Teclado

Este módulo se encarga de crear una instancia tanto del teclado,
como de las pruebas creadas para la verificación del correcto
funcionamiento del mismo.
En caso de que no se compile correctamente, revisar que la dirección
desde donde se incluye el archivo sea la correcta, es decir, 
que la carpeta desde donde se abre la terminal sea la misma donde
están los archivos.*/ 
module Teclado_tb();
    
    //!Entradas y salidas a utilizar
    wire clk,rst;
    wire [9:0] teclas;
    wire enter, verificacion;

   //! Instancia del teclado
    Teclado teclado (
        .clk(clk),
        .rst(rst), 
        .teclas(teclas),
        .enter(enter),
        .verificacion(verificacion)
    );
    //! Instancia de las pruebas realizadas
    Teclado_Test prueba (
        .clk(clk),
        .rst(rst), 
        .teclas(teclas),
        .enter(enter),
        .verificacion(verificacion)
    );
endmodule