/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    lavadora_testbench.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 29/03/2024

Descripcion: 
    Contiene el modulo que se encarga de realizar las pruebas 
con la máquina de estados creada del archivo lavadora.v
con las pruebas del archivo lavadora_tester.v para
verificar que todo funciona correctamente.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */

`include "lavadora.v"
`include "lavadora_tester.v"

//! @title Testbench de la lavadora

//!Este módulo se encarga de crear una instancia tanto de la
//!lavadora, como de las pruebas creadas para la verificación
//!del correcto funcionamiento de la misma.
//!En caso de que no se compile correctamente, revisar que la dirección
//!desde donde se incluye el archivo sea la correcta, es decir, 
//!que la carpeta desde donde se abre la terminal sea la misma donde
//!están los archivos.
module lavadora_testbench;
    //!Entradas y salidas a utilizar
    wire clk, intro_moneda, finalizar_pago, reset,lavado, secado, lavado_pesado, insuficiente;

//! Instancia de la lavadora
lavadora DUT(
    .clk(clk), 
    .intro_moneda(intro_moneda),
    .finalizar_pago(finalizar_pago),
    .reset(reset),
    .lavado(lavado), 
    .secado(secado), 
    .lavado_pesado(lavado_pesado),
    .insuficiente(insuficiente)
);

//! Instancia de las pruebas realizadas
lavadora_tester tester(
    .clk(clk), 
    .intro_moneda(intro_moneda),
    .finalizar_pago(finalizar_pago),
    .reset(reset),
    .lavado(lavado), 
    .secado(secado), 
    .lavado_pesado(lavado_pesado),
    .insuficiente(insuficiente)
);

/* Para generar las ondas y
y visualizar en gtkwave
*/
initial begin
    $dumpfile("Lavadora_testbench.vcd");
    $dumpvars;
end

endmodule