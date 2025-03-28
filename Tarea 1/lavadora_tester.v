/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    lavadora_tester.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 29/03/2024

Descripcion: 
    Contiene el módulo donde se describen las pruebas necesarias para
confirmar que el módulo de la lavanderia funciona correcta.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */

//! @title Pruebas de lavanderia 
//! En este modulo se encuentran las diferentes pruebas que confirmarán
//! el correcto funcionamiento del modulo descrito en el archivo
//! lavadora.v, de modo que se guarden en el archivo.
//!
//! Dependiendo del entorno donde se ejecute este programa, dicho archivo
//! puede guardarse en la misma carpeta que contiene este archivo, o una
//! carpeta build.
`timescale 1ns/1ns //Escala de timepo del reloj/ timeprecision

module lavadora_tester (
    output reg clk,                 //! Esta es la salida del reloj
    output reg intro_moneda,        //! Esta es la salida de ingreso de monedas
    output reg finalizar_pago,      //! Esta es la salida que finaliza el pago y ingreso de monedas
    output reg reset,               //! Esta es la salida del reset
    input wire lavado,              //! Esta es la entrada del modo lavado
    input wire secado,              //! Esta es la entrada del modo secado
    input wire lavado_pesado,       //! Esta es la entrada del modo lavado pesado
    input wire insuficiente         //! Esta es la entrada que indica un pago insuficiente
);

 //! Creación de la señal del reloj para el análisis del sistema
always begin
    #2 clk = !clk;    
end

initial begin
    clk = 0;
    reset = 1'b1;
    #4 reset = 0;
    $display("Se ha ingresado al tester");

//! Prueba 1- se activa MODO SECADORA
    repeat(3)begin
        #2 intro_moneda = 1;
        #2 intro_moneda = 0;
    end
    #12 finalizar_pago =1;
    #4  finalizar_pago =0;
    #20 reset=1;            //Apagado de señales para no interferir las demás pruebas
    intro_moneda = 0;
    finalizar_pago =0;

// Prueba 2 - se activa MODO LAVADORA


    #8 reset = 0;
    repeat(4)begin
        #2 intro_moneda = 1;
        #2 intro_moneda = 0;
    end

    #12 finalizar_pago =1;
    #4  finalizar_pago =0;
    #20 reset=1;            //Apagado de señales para no interferir las demás pruebas
    intro_moneda = 0;
    finalizar_pago =0;


// Prueba 3 se activa MODO LAVADO PESADO

    #8 reset = 0;
    repeat(9)begin
        #2 intro_moneda = 1;
        #2 intro_moneda = 0;
    end
    
    #12 finalizar_pago =1;
    #4  finalizar_pago =0;
    #20 reset=1;            //Apagado de señales para no interferir las demás pruebas
    intro_moneda = 0;
    finalizar_pago =0;


// Prueba 4 VERIFICACIÓN DE PAGO CON MONEDAS INSUFICIENTES.
    #8 reset = 0;
    repeat(2)begin
        #2 intro_moneda = 1;
        #2 intro_moneda = 0;
    end

    #12 finalizar_pago =1;
    #8 finalizar_pago =0;
    #12 reset=1;            //Apagado de señales para no interferir las demás pruebas
    intro_moneda = 0;
   

    #10 $finish;

end
endmodule