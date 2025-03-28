
# Entity: lavadora_testbench 
- **File**: lavadora_testbench.v
- **Title:**  Testbench de la lavadora

## Diagram
![Diagram](lavadora_testbench.svg "Diagram")
## Description

Este módulo se encarga de crear una instancia tanto de la
lavadora, como de las pruebas creadas para la verificación
del correcto funcionamiento de la misma.
En caso de que no se compile correctamente, revisar que la dirección
desde donde se incluye el archivo sea la correcta, es decir,
que la carpeta desde donde se abre la terminal sea la misma donde
están los archivos.

## Signals

| Name           | Type | Description                   |
| -------------- | ---- | ----------------------------- |
| clk            | wire | Entradas y salidas a utilizar |
| intro_moneda   | wire | Entradas y salidas a utilizar |
| finalizar_pago | wire | Entradas y salidas a utilizar |
| reset          | wire | Entradas y salidas a utilizar |
| lavado         | wire | Entradas y salidas a utilizar |
| secado         | wire | Entradas y salidas a utilizar |
| lavado_pesado  | wire | Entradas y salidas a utilizar |
| insuficiente   | wire | Entradas y salidas a utilizar |

## Instantiations

- DUT: lavadora
  -  Instancia de la lavadora- tester: lavadora_tester
  -  Instancia de las pruebas realizadas