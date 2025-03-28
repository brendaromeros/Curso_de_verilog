/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    calculadora.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 28/04/2024 
    
*********************************************************** */ 


//! @title calculadora
//! Este módulo se encarga de implementar un calculadora de 8 bits, la cual puede recibir un máximo de dos números; esta se 
//! controla por un reloj y señales de habilitación y reinicio. El modo de operación se ingresa a través de
//! las entradas del módulo, mientras que el resultado se genera en la salida. El comportamiento del módulo está
//! definido por un proceso siempre activo que se dispara en cada flanco positivo del reloj. Cuando la señal de
//! habilitación está activada, el proceso selecciona la operación según el modo especificado y calcula el resultado,
//! que luego se asigna a la salida. Si se activa la señal de reinicio, la salida se establece en cero. Si ninguna
//! operación coincide con el modo especificado, la salida se mantiene. Este diseño proporciona una funcionalidad
//! básica de calculadora digital, permitiendo realizar sumas, restas, multiplicaciones y desplazamientos a la izquierda
//! entre los operandos ingresados.

 module calculadora (
    input  clk,         //! Esta es la entrada del reloj
    input  enb,         //! Esta es la entrada de habilitación
    input  rst,         //! Esta es la entrada del reset
    input [7:0] a,      //! Esta es la entrada del primer número
    input [7:0] b,      //! Esta es la entrada del segundo número
    input [1:0] modo,   //! Esta es la entrada que elije que operación realizar 
    output reg[7:0] c   //! Esta es la salida del resultado
 );
 // Parametros del módulo
    parameter suma = 2'b00;             //! Código correspondiente al modo suma
    parameter resta = 2'b01;            //! Código correspondiente al modo resta
    parameter left_shift = 2'b11;       //! Código correspondiente al modo left_shift
    parameter multiplica = 2'b10;       //! Código correspondiente al modo multiplica    

// Procesos del módulo
    //!Este proceso es activado por cada flanco positivo del reloj, verificando
    //!primero si la señal de habilitación está activada. Si lo está, selecciona
    //!una operación aritmética según el modo especificado, calcula el resultado
    //!utilizando los operandos a y b, y lo asigna a la salida c. En caso de que
    //!se active la señal de reinicio, la salida se establece en cero. Este diseño
    //!proporciona un mecanismo para realizar operaciones aritméticas básicas entre
    //!dos números de 8 bits, controlado por un reloj y señales de habilitación y reinicio.
    always @(posedge clk ) begin
        if(enb) begin
            case (modo)
                suma:c <= a + b;
                resta:c <= a - b;
                left_shift:c <= a >> 3;
                multiplica:c <= a * b;
                default: c <= 0;
            endcase
        end 
        else if (rst) begin
            c <= 0;
        end
    end
    
 endmodule