/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    calle_tester.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 2/04/2024

Descripcion: 
   
*********************************************************** */

//! @title Pruebas de la calle
//! Este módulo se encarga de realizar las pruebas correspondientes
//! para saber si los semáforos funcionan correctamente
//! Dependiendo del entorno donde se ejecute este programa, dicho archivo
//! puede guardarse en la misma carpeta que contiene este archivo, o una
//! carpeta build.
`timescale 1ns/1ns //Escala de timepo del reloj/ timeprecision

module calle_tester (
// Puertos
    output reg clk,                  //! Esta es la salida del reloj
    output reg enb,                  //! Esta es la salida de encendido
    output reg[1:0] semaforo_a,      //! Esta es la salida del semáforo A
    output reg reset,                //! Esta es la salida del reset
    output reg[1:0] semaforo_b,      //! Esta es la salida del semáforo B
    input wire a_peatonal,           //! Esta es la entrada del semáforo peatonal A
    input wire b_peatonal            //! Esta es la entrada del semáforo peatonal B
);

 //! Creación de la señal del reloj para el análisis del sistema
always begin
    #2 clk = !clk;    
end

initial begin
    clk = 0;
    reset = 1'b0;
    enb = 1;
    $display("Se ha ingresado al tester");

//! Prueba 1- Semáforo A en verde y semáforo B en rojo
    semaforo_a = 2'b10;
    semaforo_b = 2'b00;
    #10 semaforo_b = 2'b01;
//! Prueba 2- Semáforo A en verde y semáforo B en verde 
    #4 semaforo_b = 2'b10;

//! Prueba 3- Semáforo A en amarillo y semáforo B en verde 
    #12 semaforo_a = 2'b01;

//! Prueba 4- Semáforo A en rojo y semáforo B en verde
    #8 semaforo_a = 2'b00;
    #8 reset = 1;
    #4  reset = 0;

//! Prueba 5- Semáforo A en rojo y semáforo B en amarillo
    #8  semaforo_a = 2'b00;
    semaforo_b = 2'b01;
//! Prueba 6- Semáforo A en rojo y semáforo B en verde eneble en 0
    #8 semaforo_b = 2'b10;  
    enb=0;
    #8 enb=1;
    semaforo_a = 2'b01;
    #4 semaforo_b = 2'b01;

//! Prueba 7- Semáforo A en verde y semáforo B en rojo 
    #8 semaforo_a = 2'b10;
    semaforo_b = 2'b00;

    #10 $finish;

end
endmodule