/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0323
                   Circuitos Digitales 1

                    Sist_Seguridad_tb.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>
        Alejandra Solano Ramírez <mariaalejandra.solano@ucr.ac.cr>
        Jun Hyun Yeom Song <jun.yeom@ucr.ac.cr>

Fecha: 27/02/2024

Descripcion: 
    Contiene el modulo que se encarga de realizar las pruebas 
con la máquina de estados creada del archivo Sist_Seguridad.v
con las pruebas del archivo Sist_Seguridad_Tests.v para
verificar que todo funciona correctamente.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */


`include "Sist_Seguridad.v"
`include "Sist_Seguridad_Tests.v"

/* @title Testbench del Sistema de seguridad

Este módulo se encarga de crear una instancia tanto de la
máquina de estados, como de las pruebas creadas para la verifi-
cación del correcto funcionamiento de la misma.
En caso de que no se compile correctamente, revisar que la dirección
desde donde se incluye el archivo sea la correcta, es decir, 
que la carpeta desde donde se abre la terminal sea la misma donde
están los archivos.*/ 
module Sist_Seguridad_tb();
    
    //!Entradas y salidas a utilizar
    wire clk,rst, ho,pw,ro,vo,v1,mo,m1,po,p1,io,lo,ao;

   //! Instancia de la máquina de estados
    Sist_Seguridad maquina (
        .clk(clk),
        .rst(rst), 
        .ho(ho),
        .pw(pw),
        .ro(ro),
        .vo(vo),
        .v1(v1),
        .mo(mo),
        .m1(m1),
        .po(po),
        .p1(p1),
        .io(io),
        .lo(lo),
        .ao(ao)
    );
    //! Instancia de las pruebas realizadas
    Sist_Seguridad_Tests patitos_s_a (
        .clk(clk),
        .rst(rst), 
        .ho(ho),
        .pw(pw),
        .ro(ro),
        .vo(vo),
        .v1(v1),
        .mo(mo),
        .m1(m1),
        .po(po),
        .p1(p1),
        .io(io),
        .lo(lo),
        .ao(ao)
    );
endmodule