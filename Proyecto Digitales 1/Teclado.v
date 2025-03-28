/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0323
                   Circuitos Digitales 1

                    Teclado.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>
        Alejandra Solano Ramírez <mariaalejandra.solano@ucr.ac.cr>
        Jun Hyun Yeom Song <jun.yeom@ucr.ac.cr>

Fecha: 27/02/2024

Descripcion: 
    Contiene el módulo de un teclado que revisa si la contraseña ingresada
mediante una interfaz que tiene 10 teclas numéricas y una de enter. Dado que la contraseña
se encuentra en formato BCD, se convierte la señal de la tecla presionada a este formato, para
que cuando se presione la tecla enter, se comparen las entradas recibidas y la clave almacenada
en el sistema con el fin de averiguar si es la correcta o no.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */


//! @title Teclado
//!  Este módulo se encarga de recibir una contraseña desde un teclado con 10 teclas numerales
//! diferentes y una de Enter, el cual espera a que se active la tecla Enter para analizar
//! la contraseña ingresada por el usuario y compararla por la que tiene con el sistema
//! para finalmente devolver un uno si estas son iguales o un cero si son diferentes,
//! en caso de que se ingresen más de cuatro números, el sistema considerará que la misma es incorrecta
//! y restablecerá el valor de la contraseña actual de modo que la salida sea 0.
//! Además, el modulo también se encarga de convertir el valor de la tecla en un número en 
//! formato BCD. 
module Teclado(
    input wire clk,          //! Esta es la entrada del reloj
    input wire rst,          //! Esta es la entrada del reset
    input wire [9:0] teclas, //! Estas son las entradas  de las teclas
    input wire enter,        //! Esta es la entrada de la tecla Enter
    output reg verificacion  //! Esta es la salida que indica si la contraseña es correcta
    );


reg [15:0] clave_temporal;   //! Esta variable tendrá el valor temporal de la contraseña mientras se escribe
reg [15:0] clave_convertida; //! Esta variable tendrá la contraseña codificada en BCD
reg [3:0]  contador;         //! Esta variable se utiliza para saber cuántas teclas se han tocado
reg estado_actual;           //! Esta variable mostrará el estado actual de la máquina
reg estado_futuro;           //! Esta variable mostrará el estado futuro de la máquina

parameter  CLAVE = 16'b0100001100100001 ; //! Contraseña del sistema: 4321
parameter a = 1'b1;                       //!Estado ingresando contraseña
parameter b = 1'b0;                       //!Estado confirmando contraseña


//! Memoria de estados de la máquina de estados, la cual se activa en cada ciclo
//! positivo del reloj o del ciclo positivo del reset
always @(posedge clk, posedge rst) begin
    if (rst) begin
        estado_actual = a; //! Se reinician los valores utilizados anteriormente
        estado_futuro = a;      
        assign verificacion = 0;
        clave_temporal = 16'h0000; 
        clave_convertida = 16'h0000;
        contador = 0;
    end else estado_actual <= estado_futuro;  
end

//! Lógica de cálculo próximo estado de la máquina de estado
always @(posedge clk, posedge rst) begin
    if(estado_actual)begin
        if (enter) begin  //! Se revisa si se ha tocado la tecla Enter
            clave_convertida = clave_temporal; //! Carga la contraseña ya convertida
            contador = 0;
            estado_actual = b;
            estado_futuro = b;

        end else begin

            //Actualización de la contraseña temporal
            if (|teclas) begin

                case (contador)

                //Caso cuando se detecta una tecla activada
                0:begin
                    if (teclas[0]) clave_temporal <= {clave_temporal[3:0],4'b0000};
                    else if (teclas[1]) clave_temporal <= {clave_temporal[3:0],4'b0001};
                    else if (teclas[2]) clave_temporal <= {clave_temporal[3:0],4'b0010};
                    else if (teclas[3]) clave_temporal <= {clave_temporal[3:0],4'b0011};
                    else if (teclas[4]) clave_temporal <= {clave_temporal[3:0],4'b0100};
                    else if (teclas[5]) clave_temporal <= {clave_temporal[3:0],4'b0101};
                    else if (teclas[6]) clave_temporal <= {clave_temporal[3:0],4'b0110};
                    else if (teclas[7]) clave_temporal <= {clave_temporal[3:0],4'b0111};
                    else if (teclas[8]) clave_temporal <= {clave_temporal[3:0],4'b1000};
                    else if (teclas[9]) clave_temporal <= {clave_temporal[3:0],4'b1001};
                end
                //Caso cuando se detectan dos teclas activadas
                1: begin
                    if (teclas[0]) clave_temporal <= {clave_temporal[7:0],4'b0000};
                    else if (teclas[1]) clave_temporal <= {clave_temporal[7:0],4'b0001};
                    else if (teclas[2]) clave_temporal <= {clave_temporal[7:0],4'b0010};
                    else if (teclas[3]) clave_temporal <= {clave_temporal[7:0],4'b0011};
                    else if (teclas[4]) clave_temporal <= {clave_temporal[7:0],4'b0100};
                    else if (teclas[5]) clave_temporal <= {clave_temporal[7:0],4'b0101};
                    else if (teclas[6]) clave_temporal <= {clave_temporal[7:0],4'b0110};
                    else if (teclas[7]) clave_temporal <= {clave_temporal[7:0],4'b0111};
                    else if (teclas[8]) clave_temporal <= {clave_temporal[7:0],4'b1000};
                    else if (teclas[9]) clave_temporal <= {clave_temporal[7:0],4'b1001};
                end
                //Caso cuando se detectan tres teclas activadas
                2: begin
                    if (teclas[0]) clave_temporal <= {clave_temporal[11:0],4'b0000};
                    else if (teclas[1]) clave_temporal <= {clave_temporal[11:0],4'b0001};
                    else if (teclas[2]) clave_temporal <= {clave_temporal[11:0],4'b0010};
                    else if (teclas[3]) clave_temporal <= {clave_temporal[11:0],4'b0011};
                    else if (teclas[4]) clave_temporal <= {clave_temporal[11:0],4'b0100};
                    else if (teclas[5]) clave_temporal <= {clave_temporal[11:0],4'b0101};
                    else if (teclas[6]) clave_temporal <= {clave_temporal[11:0],4'b0110};
                    else if (teclas[7]) clave_temporal <= {clave_temporal[11:0],4'b0111};
                    else if (teclas[8]) clave_temporal <= {clave_temporal[11:0],4'b1000};
                    else if (teclas[9]) clave_temporal <= {clave_temporal[11:0],4'b1001};
                end
                //Caso cuando se detectan cuatro teclas activadas
                3: begin
                    if (teclas[0]) clave_temporal <= {clave_temporal[15:0],4'b0000};
                    else if (teclas[1]) clave_temporal <= {clave_temporal[15:0],4'b0001};
                    else if (teclas[2]) clave_temporal <= {clave_temporal[15:0],4'b0010};
                    else if (teclas[3]) clave_temporal <= {clave_temporal[15:0],4'b0011};
                    else if (teclas[4]) clave_temporal <= {clave_temporal[15:0],4'b0100};
                    else if (teclas[5]) clave_temporal <= {clave_temporal[15:0],4'b0101};
                    else if (teclas[6]) clave_temporal <= {clave_temporal[15:0],4'b0110};
                    else if (teclas[7]) clave_temporal <= {clave_temporal[15:0],4'b0111};
                    else if (teclas[8]) clave_temporal <= {clave_temporal[15:0],4'b1000};
                    else if (teclas[9]) clave_temporal <= {clave_temporal[15:0],4'b1001};
                end

                /* En caso de que se ingresen más números de los requeridos, se reiniciará
                la clave para que en el momento de la verificación, se muestre que la contraseña
                es inncorrecta*/ 
                default: clave_temporal <= 16'h0000;

                endcase

                contador <= contador + 1;
            end       
        end
    end else begin

        //! Verificación  de contraseña
        if (clave_convertida !== CLAVE)begin
            clave_temporal = 16'h0000; //! Se reinician los valores utilizados anteriormente
            clave_convertida = 16'h0000;
            estado_futuro = a;
        end
    end

    //!Lógica de cambio de las salidas
    verificacion = (clave_convertida == CLAVE) ? 1 : 0 ;
end

endmodule
