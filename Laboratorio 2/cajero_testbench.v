/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    cajero_testbench.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 02/05/2024

Descripcion: El módulo cajero_testbench se utiliza como un entorno de pruebas
para verificar el diseño de un cajero automático. Integra instancias del cajero
y un módulo de pruebas (cajero_tester), generando estímulos de entrada como señales
de reloj, reset y datos de transacción. Observa las salidas del diseño y las compara
con resultados esperados para validar su correcto funcionamiento. La generación de un
archivo VCD permite la visualización de las señales en herramientas de simulación.
   
*********************************************************** */
`include "cajero_tester.v"
`include "cajero.v"

/* @title Testbench del cajero

Este módulo se encarga de crear una instancia tanto del cajero,
como de las pruebas creadas para la verifi-
cación del correcto funcionamiento del mismo.

En caso de que no se compile correctamente, revisar que la dirección
desde donde se incluye el archivo sea la correcta, es decir, 
que la carpeta desde donde se abre la terminal sea la misma donde
están los archivos.*/ 

module cajero_testbench;

    //!Entradas y salidas a utilizar
    wire clk, rst,tarjeta_recibida, tipo_tarjeta, digito_stb, tipo_transaccion;         //!Entradas y salidas a utilizar
    wire monto_stb, balance_actualizado, entregar_dinero, pin_incorrecto, bloqueo;      //!Entradas y salidas a utilizar
    wire advertencia, fondos_insuficientes;                                             //!Entradas y salidas a utilizar
    wire [15:0] pin;                                                                    //!Entradas y salidas a utilizar
    wire [3:0]digito;                                                                   //!Entradas y salidas a utilizar
    wire [31:0 ]monto;                                                                  //!Entradas y salidas a utilizar

    //! Instancia del cajero
    cajero DUT(
    .clk(clk),
    .rst(rst),
    .tarjeta_recibida(tarjeta_recibida),
    .tipo_tarjeta(tipo_tarjeta),
    .pin(pin),
    .digito(digito),
    .digito_stb(digito_stb),
    .tipo_transaccion(tipo_transaccion),
    .monto(monto),
    .monto_stb(monto_stb),
    .balance_actualizado(balance_actualizado),
    .entregar_dinero(entregar_dinero),
    .fondos_insuficientes(fondos_insuficientes),
    .pin_incorrecto(pin_incorrecto),
    .bloqueo(bloqueo),
    .advertencia(advertencia)
    );

    //! Instancia de las pruebas realizadas
    cajero_tester Tester(
    .clk(clk),
    .rst(rst),
    .tarjeta_recibida(tarjeta_recibida),
    .tipo_tarjeta(tipo_tarjeta),
    .pin(pin),
    .digito(digito),
    .digito_stb(digito_stb),
    .tipo_transaccion(tipo_transaccion),
    .monto(monto),
    .monto_stb(monto_stb),
    .balance_actualizado(balance_actualizado),
    .entregar_dinero(entregar_dinero),
    .fondos_insuficientes(fondos_insuficientes),
    .pin_incorrecto(pin_incorrecto),
    .bloqueo(bloqueo),
    .advertencia(advertencia)
    );

    /* Para generar las ondas y
    y visualizar en gtkwave
    */
    initial begin
        $dumpfile("cajero_testbench.vcd");
        $dumpvars;
    end

endmodule