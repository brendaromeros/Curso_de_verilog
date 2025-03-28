/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    cajero_tester.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>
        Gabriel Porras Salas <@ucr.ac.cr>

Fecha: 02/05/2024

Descripcion: El módulo `cajero_tester` simula el comportamiento del
cajero automático mediante la generación de señales de entrada como
la inserción de tarjetas, dígitos del PIN y montos a retirar o depositar.
Estas pruebas se realizan para validar el comportamiento del cajero automático
bajo diferentes escenarios y condiciones.
   
*********************************************************** */

//! @title Pruebas del cajero
//! Este módulo se encarga de realizar las pruebas correspondientes
//! para saber si el cajero funciona correctamente
//! Dependiendo del entorno donde se ejecute este programa, dicho archivo
//! puede guardarse en la misma carpeta que contiene este archivo, o una
//! carpeta build.

`timescale 1ns/1ns //Escala de timepo del reloj/ timeprecision

module cajero_tester (
    output reg clk,                              //! Esta es la salida del reloj
    output reg rst,                              //! Esta es la salida del reset
    output reg tarjeta_recibida,                 //! Esta es la salida de la tarjeta_resibida
    output reg tipo_tarjeta,                     //! Esta es la salida del tipo de tarjeta
    output reg [15:0] pin,                       //! Esta es la salida del pin de la tarjeta
    output reg [3:0]digito,                      //! Esta es la salida del digito ingresado
    output reg digito_stb,                       //! Esta es la salida de activación de teclado para los dígitos
    output reg tipo_transaccion,                 //! Esta es la salida del tipo de trasnsaccción
    output reg [31:0 ]monto,                     //! Esta es la salida del monto a retirar o depositar
    output reg monto_stb,                        //! Esta es la salida del ingreso del monto a retirar o depositar
    input  balance_actualizado,                  //! Esta es la entrada del balance actual del sistema
    input  entregar_dinero,                      //! Esta es la entrada que indica que se edebe entragar dinero
    input  fondos_insuficientes,                 //! Esta es la entrada que indica que no hay fondos suficientes para el retiro
    input  pin_incorrecto,                       //! Esta es la entrada que indica que se ingreso un pin incorrecto
    input  bloqueo,                              //! Esta es la entrada que indica que se bloqueo el cajero
    input  advertencia                           //! Esta es la entrada que indica que se esta a un intento de bloquear el cajero
    );

    //! Creación de la señal del reloj para el análisis del sistema
    always begin
        #5 clk = !clk;    
    end

    //! Definición de las variables
    initial begin
        clk = 1;
        rst = 0; 
        tarjeta_recibida = 0;
        tipo_tarjeta = 0;
        pin = 0;
        digito = 0;
        digito_stb = 0;
        tipo_transaccion = 0;
        monto = 0;
        monto_stb = 0;
    end
    
    initial begin
        
        $display("Bienvenide bebe");
        
        #20 rst =1;

    // Prueba 1: Pin correcto y deposito BCR

        //Ingreso tarjeta
        #10 tarjeta_recibida = 1;
        pin = 16'h6953;
        tipo_tarjeta = 0;       
        #10;

        // Ingreso pin correcto
        #10 digito = 6;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 5;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 3;
        digito_stb = 1;
        #10 digito_stb = 0;

        // ingreso de monto
        #20 monto = 32'd30000;
        monto_stb = 1;
        tipo_transaccion = 0;
        #10 monto_stb = 0;

        #20 tarjeta_recibida = 0;
        #40;

    // Prueba 2: Un intento incorrecto y retiro correcto otro banco

        //Ingreso tarjeta
        #10 tarjeta_recibida = 1;
        pin = 16'h6953;  
        tipo_tarjeta = 1;     
        #10;

        //Ingreso pin incorrecto
        #10 digito = 1;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 5;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 3;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10;

        //Ingreso pin correcto
        #10 digito = 6;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 5;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 3;
        digito_stb = 1;
        #10 digito_stb = 0;

        //Ingreso de monto
        #20 monto = 32'd4520;
        monto_stb = 1;
        tipo_transaccion = 1;
        #10 monto_stb = 0;

        #20 tarjeta_recibida = 0;
        #40;

    // Prueba 3: dos incorrecto y 1 retiro mal banco correcto

        //Ingreso tarjeta
        #10 tarjeta_recibida = 1;
        pin = 16'h6953;   
        tipo_tarjeta = 0;    
        #10;

       //Ingreso pin incorrecto
        #10 digito = 1;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 5;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 3;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10;

        //Ingreso pin incorrecto
        #10 digito = 1;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 7;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 3;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10;

        //Ingreso pin correcto
        #10 digito = 6;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 5;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 3;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10;

        //Ingreso monto incorrecto
        #10 monto = 32'd90000;
        monto_stb = 1;
        tipo_transaccion = 1;
        #10 monto_stb = 0;

        //Inngreso monto correcto
        #10 monto = 32'd3000;
        monto_stb = 1;
        tipo_transaccion = 1;
        #10 monto_stb = 0;
        
        #20 tarjeta_recibida = 0;
        #40;

    // Prueba 4: 3 incorrecto

        //Ingreso tarjeta
        #10 tarjeta_recibida = 1;
        pin = 16'h6953;
        tipo_tarjeta = 0;       
        #10;

       //Ingreso pin incorrecto
        #10 digito = 6;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 5;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 4;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10;

        //Ingreso pin incorrecto
        #10 digito = 1;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 7;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 3;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10;

        //Ingreso pin incorrecto
        #10 digito = 6;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 9;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 5;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10 digito = 4;
        digito_stb = 1;
        #10 digito_stb = 0;
        #10;
        
        #10 rst =0;
        tarjeta_recibida = 0;
        #10 rst =1;
        #40;

        $finish;
    end 
endmodule