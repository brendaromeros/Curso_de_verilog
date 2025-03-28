/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0323
                   Circuitos Digitales 1

                    Sist_Seguridad_Tests.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>
        Alejandra Solano Ramírez <mariaalejandra.solano@ucr.ac.cr>
        Jun Hyun Yeom Song <jun.yeom@ucr.ac.cr>

Fecha: 27/02/2024

Descripcion: 
    Contiene el modulo donde se describen las pruebas necesarias para
confirmar que el teclado funciona correctamente.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */

//! @title Pruebas del Teclado
//! En este modulo se encuentran las diferentes pruebas que confirmarán
//! el correcto funcionamiento del teclado descrito en el archivo Teclado.v, 
//! de modo que se guarden en el archivo Teclado.vcd.
//!
//! Dependiendo del entorno donde se ejecute este programa, dicho archivo
//! puede guardarse en la misma carpeta que contiene este archivo, o una
//! carpeta build.
module Teclado_Test(
    output reg clk,           //! Señal de reloj
    output reg rst,           //! Señal de reset
    output reg [9:0] teclas,  //! Señal de teclas
    output reg enter,         //! Señal de tecla enter
    input wire verificacion   //! Señal de verificación de contraseña
);
    //! Creación de la señal del reloj para el análisis del sistema
	initial clk=0; 

	always #1 begin
        clk = ~clk;
    end 

    initial begin
        $dumpfile("Teclado.vcd");
        $dumpvars;

        // Inicializa las señales de entrada
        teclas = 10'b0000000000;
        enter = 0;

    // Pruebas para el teclado
        
    // Prueba 1: Ingresa la contraseña correctamente
        #4 rst=1;
        #1 rst=0;
        teclas[4] = 1;    // Se presiona la tecla 4
        #2 teclas[4] = 0; // Se deja de precionar la tecla
        #2 teclas[3] = 1; // Se presiona la tecla 3
        #2 teclas[3] = 0; // Se deja de presionar la tecla
        #2 teclas[2] = 1; // Se presiona la tecla 2
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #2 teclas[1] = 1; // Se presiona la tecla 1
        #2 teclas[1] = 0; // Se deja de presionar la tecla
        #4 enter = 1;     // Presiona la tecla enter
        #4 enter = 0;     //Apagado de las señales para no interferir las demás pruebas

    // Prueba 2: Ingresa una contraseña incorrecta
        #4 rst=1;
        #1 rst=0;
        #1 teclas[7] = 1; // Se presiona la tecla 7
        #2 teclas[7] = 0; // Se deja de presionar la tecla
        #2 teclas[2] = 1; // Se presiona la tecla 2
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #2 teclas[3] = 1; // Se presiona la tecla 3
        #2 teclas[3] = 0; // Se deja de presionar la tecla
        #2 teclas[1] = 1; // Se presiona la tecla 1
        #2 teclas[1] = 0; // Se deja de presionar la tecla
        #4 enter = 1;     // Presiona la tecla enter
        #4 enter = 0;     //Apagado de las señales para no interferir las demás pruebas

        // Se ingresa la contraseña correcta
        #4 teclas[4] = 1; // Se presiona la tecla 4
        #2 teclas[4] = 0; // Se deja de presionar la tecla
        #2 teclas[3] = 1; // Se presiona la tecla 3
        #2 teclas[3] = 0; // Se deja de presionar la tecla
        #2 teclas[2] = 1; // Se presiona la tecla 2
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #2 teclas[1] = 1; // Se presiona la tecla 1
        #2 teclas[1] = 0; // Se deja de presionar la tecla
        #4 enter = 1;     // Presiona la tecla enter
        #4 enter = 0;     // Apagado de las señales para no interferir las demás pruebas


    // Prueba 3: Se ingresan dos contraseñas incorrectas
        #4 rst=1;
        #1 rst=0;
        #1 teclas[7] = 1; // Se presiona la tecla 7
        #2 teclas[7] = 0; // Se deja de presionar la tecla
        #2 teclas[2] = 1; // Se presiona la tecla 2
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #2 teclas[3] = 1; // Se presiona la tecla 3
        #2 teclas[3] = 0; // Se deja de presionar la tecla
        #2 teclas[1] = 1; // Se presiona la tecla 1
        #2 teclas[1] = 0; // Se deja de presionar la tecla
        #2 teclas[2] = 1; // Se presiona la tecla 2
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #4 enter = 1;     // Presiona la tecla enter
        #4 enter = 0;     //Apagado de las señales para no interferir las demás pruebas
        
        // Se ingresa la contraseña incorrecta
        #4 teclas[2] = 1; // Se presiona la tecla 4
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #2 teclas[2] = 1; // Se presiona la tecla 3
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #2 teclas[2] = 1; // Se presiona la tecla 2
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #2 teclas[2] = 1; // Se presiona la tecla 1
        #2 teclas[2] = 0; // Se deja de presionar la tecla
        #4 enter = 1;     // Presiona la tecla enter
        #4 enter = 0;     // Apagado de las señales para no interferir las demás pruebas 
       
        // Finaliza la simulación
        #10 $finish;
    end

endmodule