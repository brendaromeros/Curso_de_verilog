/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    controlador_tester.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 9/06/2024
   
*********************************************************** */



//! @title Pruebas del controlador
//! Este archivo contiene las pruebas del controlador. Se utilizan diferentes casos
//! de prueba para verificar el correcto funcionamiento del controlador en diferentes situaciones.

`timescale 1ns/1ns //Escala de timepo del reloj

module controlador_tester (
    output reg clk,              //! Esta es la salida del reloj
    output reg reset,            //! Esta es la salida del reset
    output reg [15:0] datain,    //! Esta es la salida de los datos de entrada
    output reg [1:0] slave_numb  //! Esta es la salida del número de esclavo
);

always #5 clk = !clk;

initial begin
    // Inicializando las señales
    reset = 1;
    clk = 1;
    datain = 0;
    slave_numb = 1;
    #10;
    reset = 0;
    // Prueba 01
    #10;
    datain = 16'hA569;

    #630;
    #10 slave_numb = 0;

    // Prueba 02
    #20 reset = 1;
    #30 reset = 0;
    datain = 16'h0AF0;
    slave_numb = 2;
    #640;
    #10 slave_numb = 0;
    #50 reset = 1;
    #40;
    $finish;
end

endmodule