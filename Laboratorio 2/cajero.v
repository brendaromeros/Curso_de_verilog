/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    cajero.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 28/04/2024

Descripción: 
El módulo cajero implementa la lógica de un cajero automático, gestionando diversas entradas 
y salidas para realizar operaciones como el ingreso del PIN, la verificación de tarjetas, el 
manejo de fondos y la entrega de dinero. Utiliza una máquina de estados finitos para controlar los
diferentes estados del cajero, como la espera, el ingreso del PIN, la transferencia de fondos 
y la detección de errores. La lógica interna del cajero incluye la actualización del balance, la 
verificación de fondos suficientes y el manejo de comisiones por transacciones.
    
*********************************************************** */


//! @title cajero
module cajero (
    input clk,                              //! Esta es la entrada del reloj
    input rst,                              //! Esta es la entrada del reset
    input tarjeta_recibida,                 //! Esta es la entrada de la tarjeta_resibida
    input tipo_tarjeta,                     //! Esta es la entrada del tipo de tarjeta
    input [15:0] pin,                       //! Esta es la entrada del pin de la tarjeta
    input [3:0]digito,                      //! Esta es la entrada del digito ingresado
    input digito_stb,                       //! Esta es la entrada de activación de teclado para los dígitos
    input tipo_transaccion,                 //! Esta es la entrada del tipo de trasnsaccción
    input [31:0 ]monto,                     //! Esta es la entrada del monto a retirar o depositar
    input monto_stb,                        //! Esta es la entrada del ingreso del monto a retirar o depositar
    output reg balance_actualizado,         //! Esta es la salida del balance actual del sistema
    output reg entregar_dinero,             //! Esta es la entrada que indica que se edebe entragar dinero
    output reg fondos_insuficientes,        //! Esta es la salida que indica que no hay fondos suficientes para el retiro
    output reg pin_incorrecto,              //! Esta es la salida que indica que se ingreso un pin incorrecto
    output reg bloqueo,                     //! Esta es la salida que indica que se bloqueo el cajero
    output reg advertencia                  //! Esta es la salida que indica que se esta a un intento de bloquear el cajero
);
    //Registros internos
    reg [63:0] balance;         //!Esta variable se encarga de actualizar la cantidad de dinero del cajero
    reg [2:0] estado_actual;    //!Esta variable se encarga de establecer cual es el estado actual
    reg [2:0] estado_futuro;    //!Esta variable se encarga de establecer cual será  el próximo estado
    reg dig_incorrecto;         //!Esta variable se encarga de mostrar cuando se encontró un digito incorrecto
    reg [2:0] ingresado;        //!Esta variable se encarga de contar cuantos dígitos se han ingresado

    //Estados de la máquina de estados

    parameter ESPERANDO = 3'b000;       //!Estado default que reinicia las señales a 0
    parameter INGRESO = 3'b001;         //!Estado que se encarga de verificar la entrada del pin
    parameter TRANSFERENCIA = 3'b010;   //!Estado que se encarga de hacer las transferencias de balance
    parameter UN_ERROR =  3'b011;       //!Estado que inica que ya hubo un error al ingresar el pin
    parameter DOS_ERROR = 3'b100;       //!Estado que inica que ya hubo dos errores al ingresar el pin

    //Otros parámetros

    parameter COMISION = 3.0;             //!Comisión que se cobra por usar una tarjeta de otro banco en el cajero

    //! Actualización de cambio de estados:
    //! Este proceso se encarga de reiniciar el cajero y también pasar al estado requerido
    always @(posedge clk or negedge rst) begin
        
        //! Si reset == 0, se envian todas las señales a.
        if(~rst)begin
            estado_actual <= ESPERANDO;
            estado_futuro <= ESPERANDO;
            balance <=0;    
        end else begin
        //! Se cambia de estado
            estado_actual <= estado_futuro;
        end  
    end

   
    //! Contador digitos escritos:
    //! Este proceso se encarga de contar cuantos dígitos se han
    //! ingresado y comparar dicho digito con la posición adecuada del pin
    //! para confirmar si es correcto o no.
    always @(posedge digito_stb) begin

        ingresado <= ingresado + 1;

        if (~dig_incorrecto) begin
            case (ingresado)
            0: dig_incorrecto <= (digito == pin[15:12] )? 0 : 1;
            1: dig_incorrecto <= (digito == pin[11:8]  )? 0 : 1;
            2: dig_incorrecto <= (digito == pin[7:4]   )? 0 : 1;
            3: dig_incorrecto <= (digito == pin[3:0]   )? 0 : 1; 
            endcase
        end
    end

    //! Logica de próximo estado:
    //! Este proceso se encarga de definir que salidas se deben encender 
    //! y cual será el próximo estado del cajero.
    always @(*) begin

        case(estado_actual)

            ESPERANDO: begin
                estado_futuro = tarjeta_recibida ? INGRESO: ESPERANDO;
                balance_actualizado = 0;
                fondos_insuficientes = 0;
                entregar_dinero = 0;
                pin_incorrecto = 0;
                advertencia = 0;
                bloqueo = 0;
                dig_incorrecto = 0;
                ingresado = 0;
            end

            INGRESO: begin

                if(tarjeta_recibida)begin
                    if (ingresado == 4) begin

                        pin_incorrecto = (dig_incorrecto) ? dig_incorrecto: 0;
                        estado_futuro = (dig_incorrecto) ? UN_ERROR: ingresado == 4 ? TRANSFERENCIA: ESPERANDO;
                        ingresado = 0;
                        dig_incorrecto = (dig_incorrecto) ? 0: dig_incorrecto;

                    end
                    
                end else estado_futuro = ESPERANDO;

            end

            UN_ERROR:begin

                pin_incorrecto = ingresado == 0 ? 0: pin_incorrecto;

                if(tarjeta_recibida)begin
                    
                    if (ingresado == 4) begin

                        pin_incorrecto = (dig_incorrecto) ? 1: 0;
                        advertencia = (dig_incorrecto) ? 1: 0;
                        estado_futuro = (dig_incorrecto) ? DOS_ERROR: ingresado == 4 ? TRANSFERENCIA: UN_ERROR;
                        ingresado = 0;
                        dig_incorrecto = (dig_incorrecto) ? 0: dig_incorrecto;

                    end

                end else estado_futuro = UN_ERROR;
                    
            end

            DOS_ERROR:begin

                pin_incorrecto = ingresado == 0 ? 0: pin_incorrecto;
                advertencia = 0;

                if(tarjeta_recibida)begin
                    
                    if (ingresado == 4) begin

                        pin_incorrecto = (dig_incorrecto) ? 1: 0;
                        bloqueo = (dig_incorrecto) ? 1: 0;
                        balance = (dig_incorrecto) ? 0: balance;
                        estado_futuro = (dig_incorrecto) ? ESPERANDO: ingresado == 4 ? TRANSFERENCIA: DOS_ERROR;
                        ingresado = 0;
                        dig_incorrecto = (dig_incorrecto) ? 0: dig_incorrecto;

                    end

                end else estado_futuro = DOS_ERROR;

            end

            TRANSFERENCIA:begin

            advertencia = 0;
            fondos_insuficientes= 0;
            
            if(~balance_actualizado)begin
                
                if(monto_stb)begin
                    if (tipo_transaccion)begin
                            if(tipo_tarjeta )begin

                                if ((monto+(monto*(COMISION/100.0))) <= balance)begin 
                                    balance = balance - (monto+(monto*(COMISION/100.0)));
                                    entregar_dinero = 1;
                                    balance_actualizado = 1;
                                end else fondos_insuficientes = 1;

                            end else if (monto <= balance)begin
                                balance = balance - monto;
                                entregar_dinero = 1;
                                balance_actualizado = 1;
                                
                            end else fondos_insuficientes = 1; 

                    end else begin
                        if(~balance_actualizado) begin

                            if(tipo_tarjeta) balance = balance + (monto-(monto*(COMISION/100.0)));
                            else balance = balance + monto;
                            balance_actualizado = 1;

                        end
                    end

                end
            end else estado_futuro = ESPERANDO;
                
            end 
            endcase
    end
endmodule