
# Entity: calle_testbench 
- **File**: calle_testbench.v

## Diagram
![Diagram](calle_testbench.svg "Diagram")
## Signals

| Name       | Type       | Description                   |
| ---------- | ---------- | ----------------------------- |
| clk        | wire       | Entradas y salidas a utilizar |
| enb        | wire       | Entradas y salidas a utilizar |
| reset      | wire       | Entradas y salidas a utilizar |
| a_peatonal | wire       | Entradas y salidas a utilizar |
| b_peatonal | wire       | Entradas y salidas a utilizar |
| semaforo_a | wire [1:0] |                               |
| semaforo_b | wire [1:0] |                               |

## Instantiations

- DUT: calle
  -  Instancia de la calle- tester: calle_tester
  -  Instancia de las pruebas realizadas