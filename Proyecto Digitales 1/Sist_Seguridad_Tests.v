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
    Contiene el módulo donde se describen las pruebas necesarias para
confirmar que la máquina de de estados funciona correctamente.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */

//! @title Pruebas del sistema de seguridad
//! En este modulo se encuentran las diferentes pruebas que confirmarán
//! el correcto funcionamiento de la máquina descrita en el archivo
//! Sist_Seguiridad.v, de modo que se guarden en el archivo Sist_Seguridad.vcd.
//!
//! Dependiendo del entorno donde se ejecute este programa, dicho archivo
//! puede guardarse en la misma carpeta que contiene este archivo, o una
//! carpeta build.
module Sist_Seguridad_Tests (
    output reg clk, //! Esta es la salida del reloj
    output reg rst, //! Esta es la salida del reset
    output reg ho, //! Esta es la salida del detector de humo
    output reg pw, //! Esta es la salida de la contraseña
    output reg ro, //! Esta es la salida del cronómetro
    output reg vo, //! Esta es la salida de la ventana cero
    output reg v1, //! Esta es la salida de la ventana uno
    output reg mo, //! Esta es la salida del sensor de movimiento cero
    output reg m1, //! Esta es la salida del sensor de movimiento uno
    output reg po, //! Esta es la salida de la puerta cero
    output reg p1, //! Esta es la salida de la puerta uno
    input wire io, //! Esta es la entrada de la alarma de incendios
    input wire lo, //! Esta es la entrada de las luces de advertencia
    input wire ao  //! Esta es la entrada de la alarma de robos
);
    //! Creación de la señal del reloj para el análisis del sistema
	initial clk=0; 

	always #1 begin
        clk = ~clk;
    end 
    initial begin
        $dumpfile("Sist_Seguridad.vcd");
        $dumpvars;

    // Pruebas para el Sistema

	// Prueba 1 - Comienza desarmado y se arma correctamente
        rst=1;
        #1 rst = 0;
        #2 ho = 0;
        #2 pw = 1;
        #2 ro = 1;
        #2;
        pw = 0;
        ro = 0; //Apagado de señales para no interferir las demás pruebas
    
    // Prueba 2 - Comienza desarmado y hay una ventana abierta
        #4 rst = 1;
        #1 rst = 0;
        v1 = 1;
        #2 v1 = 0; //Apagado de señales para no interferir las demás pruebas

    // Prueba 3 - Comienza armado y se desarma correctamente
        #4 rst = 1;
        #1 rst=0;
        ho = 0; //Estado Armado
        pw = 1;
        ro = 1;
        #4 rst = 1; // Dado que no hay caminos para pasar directamente del estado a al b, se hace un reset
        #1 rst = 0;
        pw = 0; //Apagado de señales para no interferir las demas pruebas
        ro = 0;

    // Prueba 4 - Comienza armado y se abre una ventana
        #4 rst = 1;
        #1 rst = 0;
        ho = 0; //Estado Armado
        pw = 1;
        ro = 1;
        #4 vo = 1;
        pw = 0; //Se apagan las señales para que no detecte la contraseña
        ro = 0;
        #2 vo = 0;//Apagado de señales para no interferir las demas pruebas

    // Prueba 5 - Comienza armado y se abre una puerta, el usuario ingresa la contraseña correcta
        #4 rst = 1;
        #1 rst = 0;
        ho = 0; //Estado Armado
        pw = 1;
        ro = 1;
        #4 po = 1;
        ro = 0; //Se apaga la señal para que no detecte el estado armado
        #2 po = 0;  //Apagado de señales para no interferir las demas pruebas

    // Prueba 6 - Comienza armado y el empleado ingresa la contraseña incorrecta dos veces
        #4 rst = 1;
        #1 rst = 0;
        ho = 0; //Estado Armado
        pw = 1;
        ro = 1;
        #4 p1 = 1;
        ro = 0; 
        pw = 0;
        #2 p1 = 0; //Apagado de señales para no interferir las demás pruebas

    // Prueba 7 - Comienza armado y se activa la alarma contra incendios
        #4 rst = 1;
        #1 rst = 0;
        ho = 0; //Estado armado
        pw = 1;
        ro = 1;
        #4 ho = 1;
        ro = 0;
        pw = 0;
        #2 ho = 0; //Apagado de señales para no interferir las demás pruebas

    // Prueba 8 - Comienza desarmado y se activa la alarma contra incendios
        #4 rst = 1;
        #1 rst = 0;
        #2 ho = 1;
        #2 ho = 0; //Apagado de señales para no interferir las demás pruebas
        
    // Prueba 9 - Comienza armado, se detecta movimiento y se ingresa la contraseña correcta
        #4 rst = 1;
        #1 rst = 0;
        ho = 0; //Estado armado
        pw = 1;
        ro = 1;
        #2 ro = 0; //Apagado de señales para no detectar el estado armado
        pw = 0;
        #4 mo = 1;
        #4 pw = 1;
        #2 mo =0;
        pw =0; //Apagado de señales para no interferir las demás pruebas

        
    // Prueba 10 - Comienza en estado de incendio y se ingresa la contraseña correcta
        #4 rst = 1;
        #1 rst = 0;
        ho = 1; //Estado incendio
        #4 pw = 1;
        ho = 0;
        #2 ro = 0; //Apagado de señales para no interferir las demás pruebas
        pw =0;

        #10 $finish;
    end

endmodule