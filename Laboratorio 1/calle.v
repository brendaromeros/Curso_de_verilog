/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    calle.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 2/04/2024

Descripción: Este es el módulo que se encarga de controlar
los semáforos peatonales de una calle según los colores que tienen
los semáforos vehículares. 
    
*********************************************************** */


//! @title calle 
module calle (
// Puertos
    input wire clk,                  //! Esta es la entrada del reloj
    input wire enb,                  //! Esta es la entrada de encendido
    input wire[1:0] semaforo_a,      //! Esta es la entrada del semáforo A
    input wire reset,                //! Esta es la entrada del reset
    input wire[1:0] semaforo_b,      //! Esta es la entrada del semáforo B
    output reg a_peatonal,           //! Esta es la salida del semáforo peatonal A
    output reg b_peatonal            //! Esta es la salida del semáforo peatonal B
);   
// Parametros del módulo 
    parameter rojo = 2'b00;         //! Color rojo del semáforo
    parameter amarillo = 2'b01;     //! Color amarillo del semáforo
    parameter verde = 2'b10;        //! Color verde del semáforo

// Procesos del módulo
    //! Este proceso se encarga de revisar primeramente, si la 
    //! entrada eneble esta activa o no, y si el reset esta desactivado
    //! de modo que revise posteriormente las condiciones para que los
    //! semáforos se activen, donde en caso de que el semáforo a este en rojo
    //! y el b este en verde, se procederá a activar el semáforo peatonal a, en
    //! caso contrario, se encenderá el b, si ninguna de estas situaciones, sucede
    //! ambos semáforos se mantendrán apagados
    always @(posedge clk) begin 
        if (enb && ~reset) begin
            if(semaforo_a == rojo && semaforo_b == verde)begin
                a_peatonal <= 1;
                b_peatonal <= 0;
            end else if(semaforo_b == rojo && semaforo_a == verde)begin
                a_peatonal <= 0;
                b_peatonal <= 1;
            end else begin
                a_peatonal <= 0;
                b_peatonal <= 0;
            end
                                  
        end else if (reset) begin
            a_peatonal <= 0;
            b_peatonal <= 0;
        end
    end
    
endmodule