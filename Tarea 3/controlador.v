/************************************************************
                    Universidad de Costa Rica
                 Escuela de Ingenieria Electrica
                            IE0523
                   Circuitos Digitales 2

                    calculadora.v

Autores: 
        Brenda Romero Solano <brenda.romero@ucr.ac.cr>

Fecha: 9/6/2024 
    
*********************************************************** */ 


//! @title Master
//! Este módulo Verilog implementa un controlador maestro SPI que se comunica con dos esclavos.
//! El módulo utiliza una máquina de estados finitos (FSM) con tres estados para controlar la 
//! transmisión de datos SPI. En el estado inicial, espera a que se seleccione un esclavo.
//! Una vez seleccionado, comienza la transmisión de datos, ajustando las señales spi_cs y spi_sclk,
//! y gestionando los registros de datos mosi y miso. La FSM asegura que solo el esclavo seleccionado
//! esté activo, evitando conflictos en la línea MISO. Las señales de salida se asignan en función de
//! los registros internos y las entradas, permitiendo una comunicación SPI eficiente y sin conflictos.

module master (
    input clk,              //! Esta es la entrada del reloj
    input reset,            //! Esta es la entrada de reset
    input [15:0] datain,    //! Esta es la entrada de datos
    input [1:0]MISO,        //! Esta es la entrada de datos MISO
    input [1:0]slave_numb,  //! Esta es la entrada de selección de esclavo
    output CS_1,            //! Esta es la salida de selección del esclavo 1
    output CS_2,            //! Esta es la salida de selección del esclavo 2
    output SCLK,            //! Esta es la salida del reloj del SPI
    output [1:0]MOSI,       //! Esta es la salida de datos MOSI
    output [6:0] counter    //! Esta es la salida del contador
);

reg [15:0]  mosi;           //! Esta variable se encarga de almacenar los datos del master a un esclavo
reg [15:0]  miso;           //! Esta variable se encarga de almacenar los datos del esclavo al master
reg [2:0] state;            //! Esta variable representa el estado actual de la máquina de estados
reg [6:0] count;            //! Esta variable lleva la cuenta de los ciclos de reloj para la transmisión de datos
reg spi_cs;                 //! Esta variable controla la señal de selección del esclavo
reg spi_sclk;               //! Esta variable controla la señal de reloj del SPI

//! La lógica de cambio de estados
//! El módulo "master" tiene tres estados: estado 0, estado 1 y estado 2. En el estado 0, el módulo 
//! espera a que se seleccione un esclavo y configura las señales correspondientes. Luego, pasa al 
//! estado 1, donde comienza la transmisión de datos. En este estado, se ajustan las señales spi_cs 
//! y spi_sclk, y se gestionan los registros de datos mosi y miso. Finalmente, el módulo pasa al 
//! estado 2, donde se realiza la transición de reloj y se actualizan las señales según las 
//! condiciones establecidas. Si se cumple alguna de estas condiciones, el módulo vuelve al estado 0 
//! y reinicia las señales y registros correspondientes.

always @(posedge clk) begin
    if(reset) begin
        state <= 0;
        mosi <= 16'b0;
        miso <= 16'b0;
        count <=6'd32;
        spi_cs <= 1'b1;
        spi_sclk <= 1'b0;

    end else begin

        case (state)
            0 : begin
                mosi <= 16'b0;
                miso <= 16'b0;
                count <= 6'd32;
                spi_cs <= 1'b1;
                spi_sclk <= 1'b0;
                if(slave_numb != 0) begin
                    state <= 1;
                end
            end 
            1 :  begin
                spi_cs <= 0;
                spi_sclk <= 0;
                if (count > 16) begin
                    mosi <= datain[count-17];
                end else if (count <= 16) begin
                    miso[count-1] <= MISO;
                    mosi <= 0;
                end
                count <= count - 1;
                state <= 2;
            end
            2 : begin
                spi_sclk <= 1;
                if(count == 0) begin
                    state <= 0;
                    mosi <= 16'b0;
                    miso <= 16'b0;
                    count <= 6'd33;
                    spi_cs <= 1'b1;
                    spi_sclk <= 1'b0;
                end else if (count == 16) begin 
                    mosi <= 0;
                    state <= 1;
                end else if(count != 16) begin
                    state <= 1;
                end
            end
            default: state <= 0;
        endcase
    end
end

assign MOSI = mosi;                             //! Se actualiza la salida con los datos de la variable interna
assign counter = count;                         //! Se asigna el valor del contador interno a la salida
assign CS_1 = slave_numb == 1 ? spi_cs : 1;     //! Se asigna la señal de selección del esclavo 1 si el número de esclavo es 1, de lo contrario se asigna 1
assign CS_2 = slave_numb == 2 ? spi_cs : 1;     //! Se asigna la señal de selección del esclavo 2 si el número de esclavo es 2, de lo contrario se asigna 1
assign SCLK = spi_sclk;                         //! Se asigna la señal de reloj del SPI a la salida


endmodule

//! @title Slave
//! Este módulo Verilog implementa un esclavo SPI que se comunica con el controlador maestro.
//! El módulo utiliza una máquina de estados finitos (FSM) con tres estados para controlar la 
//! transmisión de datos SPI. En el estado inicial, el esclavo espera a que el controlador maestro
//! lo seleccione y configura las señales correspondientes. Luego, en el estado 1, el esclavo 
//! recibe los datos del controlador maestro y los almacena en el registro mosi. En el estado 2,
//! el esclavo transmite los datos almacenados en el registro mosi al controlador maestro a través
//! de la señal MISO. La FSM asegura que solo el esclavo seleccionado esté activo, evitando 
//! conflictos en la línea MISO.

module slave (
    input reset,            //! Esta es la entrada de reset
    output [1:0]MISO,       //! Esta es la salida de datos MISO
    input cs,               //! Esta es la entrada de selección del esclavo
    input SCLK,             //! Esta es la entrada del reloj del SPI
    input [6:0]counter,     //! Esta es la entrada del contador
    input [1:0]MOSI         //! Esta es la entrada de datos MOSI
);

reg [15:0]  mosi;           //! Esta variable se encarga de almacenar los datos del esclavo al master
reg [15:0]  miso;           //! Esta variable se encarga de almacenar los datos del master a un esclavo
reg [2:0] state;            //! Esta variable representa el estado actual de la máquina de estados

always @( posedge reset) begin
    miso <= 16'b0;
    state <= 0;
    mosi <= 0;
end

//! La lógica de cambio de estados
//! El módulo "slave" tiene tres estados: estado 0, estado 1 y estado 2. En el estado 0, el esclavo 
//! espera a que el controlador maestro lo seleccione y configura las señales correspondientes. Luego, 
//! en el estado 1, el esclavo recibe los datos del controlador maestro y los almacena en el registro 
//! mosi. En el estado 2, el esclavo transmite los datos almacenados en el registro mosi al controlador 
//! maestro a través de la señal MISO. La FSM asegura que solo el esclavo seleccionado esté activo, 
//! evitando conflictos en la línea MISO.

always @(posedge SCLK) begin
    case (state)
        0 : begin
            miso <= 16'b0;
            mosi <= 16'b0;
            if (~cs) begin
                state <= 1;
                mosi[15] <= MOSI;
            end
        end 
        1: begin
            if (counter > 16) begin
                mosi[counter-16] <= MOSI;
            end else begin 
                mosi[0] <= MOSI;
                state <= 2;
                miso <= mosi[15];
            end
        end
        2 :  begin
            if(counter == 0) begin
                miso <= mosi[0];
                mosi <= 16'b0;
                state <= 0;
            end  else  if (counter == 33) begin
                miso <=  16'b0;
            end else begin
                miso <= mosi[counter-1];
            end
        end
        default: state <= 0;
    endcase
end

assign MISO = state == 2 ? miso: 0;    

endmodule

//! @title Controlador
//! Este módulo Verilog implementa un controlador que utiliza el módulo maestro y dos módulos esclavos
//! para realizar la comunicación SPI. El controlador recibe datos de entrada y un número de esclavo
//! para seleccionar el esclavo correspondiente. Luego, el controlador utiliza el módulo maestro para
//! transmitir los datos al esclavo seleccionado y recibir los datos del esclavo. Los datos recibidos
//! se combinan y se envían como salida.

module controlador (
    input clk,              //! Esta es la entrada del reloj
    input reset,            //! Esta es la entrada de reset
    input [15:0] datain,    //! Esta es la entrada de datos
    input [1:0]slave_numb   //! Esta es la entrada de selección de esclavo
);
   wire SCLK,CS_1,CS_2;
   wire [1:0]MISO_1,MISO_2,MOSI;
   wire [6:0] counter;

   //! Instancia del master
    master master (
     .clk(clk),
     .reset(reset),
     .datain(datain),
     .CS_1(CS_1),
     .CS_2(CS_2),
     .SCLK(SCLK),
     .MOSI(MOSI),
     .counter(counter),
     .slave_numb(slave_numb),
     .MISO({1'b0,MISO_1||MISO_2})
     );
    //! Instancia del primer slave
     slave slave_1 (
     .reset(reset),
     .MISO(MISO_1),
     .cs(CS_1),
     .SCLK(SCLK),
     .counter(counter),
     .MOSI(MOSI)
     );
    //! Instancia del segundo slave
     slave slave_2 (
     .reset(reset),
     .MISO(MISO_2),
     .cs(CS_2),
     .SCLK(SCLK),
     .counter(counter),
     .MOSI(MOSI)
     );
endmodule
