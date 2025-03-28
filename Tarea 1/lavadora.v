/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    lavadora.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 29/03/2024

Descripción: 
    Contiene el módulo de un contralador que simule el uso de una
lavandería,donde según la cantidad de monedas ingresadas al presionar
la opción finalizar_pago, se activa alguna de las tres señales secado,
lavado, lavado pesado pero si la cantidad de monedas ingresadas es 
insuficiente para alguno los modos, se activa una señal llamada insuficiente.

Nota: Si utiliza la extensión TerosHDL y presiona desde el menú
desplegado el icono de libro, podrá tener una mejor vista de la 
documentación.
*********************************************************** */


//! @title Lavandería
//! Este módulo se encarga de controlar la activación de las salidas 
//! secado, lavado, lavado_pesado y insuficiente, las cuales se activarán
//! dependiendo de la cantidad de monedas ingresadas por el usuario al
//! presionar el botón finalizar_pago. 
module lavadora (
// Puertos
    input wire clk,                  //! Esta es la entrada del reloj
    input wire intro_moneda,         //! Esta es la entrada de ingreso de monedas
    input wire finalizar_pago,       //! Esta es la entrada que finaliza el pago y ingreso de monedas
    input wire reset,                //! Esta es la entrada del reset
    output reg lavado,               //! Esta es la salida del modo lavado
    output reg secado,               //! Esta es la salida del modo secado 
    output reg lavado_pesado,        //! Esta es la salida del modo lavado pesado
    output reg insuficiente          //! Esta es la salida que indica un pago insuficiente

);
// Señales internas del módulo  
    reg mantener_insuficiente;      //! Esta variable se utiliza para mantener la salida insuficiente encendida solo un ciclo de reloj
    reg [2:0]mantener_opcion;       //! Esta variable se utiliza para mantener la salidas lavado, lavado_pesado y secado encendidas hasta 7 ciclos de reloj
    reg[3:0] verificacion_de_pago;  //! Esta variable se encarga de contar cuantas  ingresa el usuario monedas 

     
// Parametros del módulo 
    parameter pago_lavado = 4'b0100;    //! Cantidad de monedas para lavado
    parameter pago_lav_p = 4'b1001;     //! Cantidad de monedas para lavado pesado
    parameter pago_secado = 4'b0011;    //! Cantidad de monedas para secado
    parameter ciclos_extra = 3'd5;      //! Cantidad de ciclos extra que se debe mantener encendida la señal

// Tareas del módulo
    //! Esta tarea se encarga de resetear las salidas a 0, además, establece la
    //! cantidad de ciclos extra que se deban mantener activas las señales
    task reiniciar;
        begin
            verificacion_de_pago <= 0;
            secado <= 0;
            mantener_insuficiente <= 1;
            mantener_opcion <= ciclos_extra;
            lavado <= 0;
            lavado_pesado <= 0;
            secado <= 0;
        end
    endtask

    task elegir_salida(input opcion);
        case (verificacion_de_pago)

                pago_lavado:begin
                    lavado <= opcion;
                end
                pago_lav_p:begin
                    lavado_pesado <= opcion;
                end
                pago_secado:begin
                    secado <= opcion;
                end
        endcase
    endtask
// Procesos del módulo

    //! Este proceso se encarga de decidir que salidas se activan en cada flanco
    //! positivo del reloj.
    //! Se revisa si la cantidad de monedas es adecuada para alguna de las opciones de la lavanderia,
    //! de ser este el caso se enciende la señal correespondiente.
    //! Si no se ingresó una cantidad adecuada, se procede a reiniciar las señales, como se utilizan
    //! operadores de ejecución simultanea, la señal se apaga al detectar mantener_insuficiente es 0.
    //! Para apagar las señales después del tiempo necesario, se revisa si hay alguna encendida y si
    //! la cantidad de ciclos adicionales a mantenerla es mayor a uno, si lo anterior se cumple,
    //! significa que debemos restar uno a la variable mantener opción ya que esta esta activada en
    //! este ciclo, de lo contrario, si ya la señal se mostro la cantidad de ciclos establecida, se
    //! procede a apagar la misma mediante la tarea reiniciar.
    always @(posedge clk) begin
        
        if (reset) begin
            reiniciar();                      
        end else if (intro_moneda) begin
            verificacion_de_pago <= verificacion_de_pago + 1; 
        end
        if (finalizar_pago) begin

            case (verificacion_de_pago)

            pago_lavado:begin
                lavado <= 1;
            end
            pago_lav_p:begin
                lavado_pesado <= 1;
            end
            pago_secado:begin
                secado <= 1;
            end

            default: begin
                reiniciar();
                if (mantener_insuficiente)begin
                    insuficiente <= 1;
                end else begin
                    insuficiente <= 0;
                end
                mantener_insuficiente <=0;
            end
            endcase
        end

        if (mantener_opcion % 2 == 0) begin
            elegir_salida(1);
            mantener_opcion <= mantener_opcion - 1; 

        end else if((secado||lavado||lavado_pesado)&&  mantener_opcion > 1)begin
            elegir_salida(0);
            mantener_opcion  <= mantener_opcion - 1;     
        end else if (mantener_opcion == 1 ) begin
            reiniciar();
        end
       
    end
    
endmodule