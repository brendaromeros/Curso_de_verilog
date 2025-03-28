/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0323
                   Circuitos Digitales 1

                    Sist_Seguridad.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>
        Alejandra Solano Ramírez <mariaalejandra.solano@ucr.ac.cr>
        Jun Hyun Yeom Song <jun.yeom@ucr.ac.cr>

Fecha: 27/02/2024

Descripción: 
    Contiene el módulo de un sistema de seguridad de
una empresa que utiliza los distintos sensores para proteger
a la misma de situaciones peligrosas.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */


//! @title Sistema de seguridad
//! Este módulo se encarga de controlar la activación de las luces de seguridad
//! dependiendo del estado en el que se encuentre la máquina, de modo que si se detecta alguna
//! situación peligrosa, se pueda identificar de manera correcta para poder resolver la situación
//! satisfactoriamente. 
module Sist_Seguridad (
    input wire clk, //! Esta es la entrada del reloj
    input wire rst, //! Esta es la entrada del reset
    input wire ho, //! Esta es la entrada del detector de humo
    input wire pw, //! Esta es la entrada de la contraseña
    input wire ro, //! Esta es la entrada del cronómetro
    input wire vo, //! Esta es la entrada de la ventana cero
    input wire v1, //! Esta es la entrada de la ventana uno
    input wire mo, //! Esta es la entrada del sensor de movimiento cero
    input wire m1, //! Esta es la entrada del sensor de movimiento uno
    input wire po, //! Esta es la entrada de la puerta cero
    input wire p1, //! Esta es la entrada de la puerta uno
    output reg io, //! Esta es la salida de la alarma de incendios
    output reg lo, //! Esta es la salida de las luces de advertencia
    output reg ao  //! Esta es la salida de la alarma de robos
    );
    
    reg[2:0] estado_actual; //! Esta variable mostrará el estado actual de la máquina
    reg[2:0] estado_futuro; //! Esta variable mostrará el estado futuro de la máquina

    // Asignación de estados
    parameter a = 3'b000; //!Estado Desarmado
    parameter b = 3'b111; //!Estado Armado
    parameter c = 3'b010; //!Estado Robo
    parameter d = 3'b011; //!Estado de Entrada Autorizada
    parameter e = 3'b100; //!Estado de Entrada Autorizada con un Intento Fallido
    parameter f = 3'b001; //!Estado de Incendio

    //! Memoria de estados de la máquina de estados, la cual se activa en cada ciclo
    //! positivo del reloj o del ciclo positivo del reset

    always @(posedge clk, posedge rst) begin
        if (rst) estado_actual = a;
        else estado_actual <= estado_futuro;  
    end

    //! Lógica de cálculo próximo estado de la máquina de estados
    always @(*) begin
        case (estado_actual)

            /* En esta sección se muestran las distintas formas
            de pasar a otros estados desde el estado a*/
            a:begin
                if (ho) estado_futuro = f;
                else if(pw & ro) estado_futuro = b;
                else estado_futuro = a;
            end

            /* En esta sección se muestran las distintas formas
            de pasar a otros estados desde el estado b*/
            b:begin
                if (vo|v1|mo|m1) estado_futuro = c;
                else if (po|p1) estado_futuro = d;
                else if (ho) estado_futuro = f;
                else estado_futuro = b;
            end

            /* En esta sección se muestran las distintas formas
            de pasar a otros estados desde el estado c*/
            c:begin
                if (pw) begin
                    estado_futuro = a;
                end else begin
                    estado_futuro = c; 
                end 
            end

            /* En esta sección se muestran las distintas formas
            de pasar a otros estados desde el estado d*/
            d:begin
                case ({ro,pw})
                    2'b00: estado_futuro = e;
                    2'b01: estado_futuro = a;
                    2'b10: estado_futuro = c;
                    2'b11: estado_futuro = c;
                endcase
            end

            /* En esta sección se muestran las distintas formas
            de pasar a otros estados desde el estado e*/
            e:begin
                if (pw) begin
                    estado_futuro = a;
                end else begin
                    estado_futuro = c; 
                end
            end

            /* En esta sección se muestran las distintas formas
            de pasar a otros estados desde el estado f*/
            f:begin
                if (pw) begin
                    estado_futuro = a;
                end else begin
                    estado_futuro = f; 
                end
            end

        endcase
        
    //! Lógica de cambio de las salidas la cual indica cuando se encienden las salidas
        io = (estado_actual == f) ? 1: 0;
        lo = ((estado_actual == c) | (estado_actual == d)| ( estado_actual == e) | (estado_actual == f )) ? 1:0;
        ao = (estado_actual == c) ? 1 : 0;    
    end
endmodule