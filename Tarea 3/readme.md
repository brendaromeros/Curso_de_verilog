# Proyecto de Simulación en Verilog

## Descripción

Este proyecto implementa y simula un sistema en Verilog utilizando herramientas como `make` y `GTKwave` para la compilación, ejecución y análisis de la simulación. Se diseñó un sistema que gestiona diferentes modos de operación en función de entradas específicas.

## Requisitos

Para ejecutar el proyecto, asegúrate de contar con las siguientes herramientas instaladas:

- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKwave](http://gtkwave.sourceforge.net/)
- `make` (para automatizar la compilación y simulación)

## Instrucciones de Uso

1. **Descargar y Extraer el Proyecto:**

   - Descarga el archivo ZIP del repositorio.
   - Extrae el contenido en un directorio de tu elección.

2. **Navegar hasta el Proyecto:**

   - Abre una terminal y dirígete al directorio donde extrajiste los archivos:
     ```sh
     cd nombre_del_proyecto
     ```

3. **Ejecutar el Comando ****`make`****:**

   - Para compilar, ejecutar y visualizar la simulación en `GTKwave`, simplemente ejecuta:
     ```sh
     make
     ```
   - Esto generará el archivo `.vcd` necesario para analizar la simulación.

### Comandos Individuales

Si prefieres ejecutar cada paso de forma independiente, puedes usar los siguientes comandos:

- **Compilar el código:**
  ```sh
  make compile
  ```
- **Ejecutar la simulación:**
  ```sh
  make run
  ```
- **Abrir la simulación en GTKwave:**
  ```sh
  make view
  ```
- **Eliminar archivos temporales:**
  ```sh
  make clean
  ```

## Análisis de Resultados

A continuación, se presentan los principales hallazgos de la simulación:

1. **Inicialización del Sistema:**

   - Antes del primer ciclo de reloj, las salidas no tienen valores definidos.
   - Con la activación del `reset`, los valores iniciales se establecen correctamente.

2. **Modos de Operación:**

   - Se validó que los modos `secado`, `lavado` y `lavado pesado` se activan correctamente según la cantidad de monedas ingresadas.
   - Cada modo se mantiene activo por un tiempo adecuado antes de volver al estado inicial.

3. **Caso de Saldo Insuficiente:**

   - Si se ingresan menos monedas de las necesarias, el sistema activa la señal de "insuficiente" durante un ciclo de reloj.

4. **Simulación del Protocolo SPI:**

   - Al activar el `reset`, el controlador inicia en su estado de reposo.
   - Se activa el esclavo 1 (`slave_1`) cuando `slave_numb` es 1.
   - Al recibir un dato en `dato_in`, el `master` lo transmite al `slave` seleccionado.
   - Un contador controla la transmisión de los 16 bits del dato.
   - Se verificó que el `slave_1` recibe correctamente los datos enviados.
   - El `slave` reenvía los datos guardados en la variable `mosi`, almacenándolos en `miso` del `master`.
   - La señal `cs_1` vuelve a alto tras completar la transmisión.
   - Se realizó una segunda prueba con `slave_2`, verificando su correcto funcionamiento.

## Conclusiones

- El sistema se inicializa correctamente gracias al `reset`.
- Los modos de operación funcionan de acuerdo con la lógica definida.
- El sistema detecta y maneja correctamente situaciones de saldo insuficiente.
- El controlador SPI simula correctamente la comunicación con dos `slaves`, garantizando la correcta transmisión y recepción de datos.

## Autor

Brenda Romero Solano

## Licencia

Este proyecto está bajo la licencia [MIT](https://opensource.org/licenses/MIT).

