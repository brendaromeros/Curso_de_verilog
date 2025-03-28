/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    calculadora_tester.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 28/04/2024

Descripcion: 
   
*********************************************************** */

//! @title Pruebas de la calle
//! Este módulo se encarga de realizar las pruebas correspondientes
//! para saber si la calculadora funcionan correctamente
//! Dependiendo del entorno donde se ejecute este programa, dicho archivo
//! puede guardarse en la misma carpeta que contiene este archivo, o una
//! carpeta build.

`timescale 1ns/1ns //Escala de timepo del reloj

module calculadora_tester (
    output reg  clk,         //! Esta es la salida del reloj
    output reg  enb,         //! Esta es la salida de eneble
    output reg  rst,         //! Esta es la salida del reset
    output reg [7:0] a,      //! Esta es la salida del primer número
    output reg [7:0] b,      //! Esta es la salida del segundo número
    output reg [1:0] modo,   //! Esta es la salida que elije que operación realizar 
    input [7:0] c            //! Esta es la entrada del resultado
);

// Definiendo el clk
always begin 
    #5 clk = !clk; 
end

initial begin
    clk = 1;
    rst = 1;
    enb = 1;
    a = 0;
    b= 0;
    modo =2'b00;
end

initial begin

    $display("Bienvenido a las pruebas de la calculadora");
    
    #20 rst =0;

// Prueba 01. Suma donde a es 87 y b es 98
    a = 8'd87;
    b = 8'd98;
    #10 $display(" Suma donde a es %d y b es %d: %d", a, b, c);
   
// Prueba 02. Suma donde a es 75 y b es 69
    a = 8'd75;
    b = 8'd69;
    #10 $display(" Suma donde a es %d y b es %d: %d", a, b, c);

    modo =2'b01;

// Prueba 03. Resta donde a es 98 y b es 37
    a = 8'd98;
    b = 8'd37;
    #10 $display(" Resta donde a es %d y b es %d: %d", a, b, c);

// Prueba 04. Resta donde a es 87 y b es 25
    a = 8'd87;
    b = 8'd25;
    #10 $display(" Resta donde a es %d y b es %d: %d", a, b, c);
    
    modo =2'b10;

// Prueba 05. Multiplicación donde a es 57 y b es 2
    a = 8'd57;
    b = 8'd2;
    #10 $display(" Multiplicacion donde a es %d y b es %d: %d", a, b, c);

// Prueba 06. Multiplicación donde a es 85 y b es 3
    a = 8'd85;
    b = 8'd3;
    #10 $display(" Multiplicacion donde a es %d y b es %d: %d", a, b, c);

    modo =2'b11;

// Prueba 07. Left shift donde a es 57
    a = 8'd57;
    #10 $display(" Left shift donde a es %b: %b", a, c);

// Prueba 08. Left shift donde a es 253
    a = 8'd253;
    #10 $display(" Left shift donde a es %b: %b", a, c);

    enb = 1'b0;
    rst = 1'b1;
    #10;

    $finish;
end
    
endmodule