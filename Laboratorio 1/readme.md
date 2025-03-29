# Proyecto de Control de Semáforos Peatonales en Verilog

## Descripción

En este laboratorio se implementó un controlador para los semáforos peatonales de una calle específica, donde tanto vehículos como peatones comparten el espacio. El objetivo principal del controlador es garantizar que los semáforos peatonales se activen únicamente en momentos seguros para que los peatones crucen la calle, coordinando los cambios de estado con los semáforos para vehículos. Esto ayuda a prevenir accidentes y minimizar el riesgo de colisiones o atropellos.

## Ejecución del Programa

Para utilizar el programa, sigue los pasos a continuación:

1. **Descargar y Extraer el Proyecto:**
   - Descarga el archivo ZIP del repositorio.
   - Descomprímelo en el directorio de tu elección.

2. **Ubicarte en la Carpeta del Proyecto:**
   - Abre una terminal y navega hasta la carpeta del proyecto:
     ```sh
     cd ruta/al/proyecto
     ```

3. **Ejecutar el Comando `make`:**
   - Ejecuta:
     ```sh
     make
     ```
   - Este comando compila automáticamente el proyecto, revisando los archivos en busca de problemas y generando el archivo `.vcd` necesario para el análisis de la simulación.

4. **Visualización de la Simulación:**
   - `make` abre automáticamente GTKwave, una herramienta que permite inspeccionar y analizar el comportamiento de los circuitos simulados, facilitando la comprensión de los resultados.

5. **Limpieza del Proyecto:**
   - `make` se encarga de eliminar los archivos temporales generados durante la compilación y ejecución, manteniendo el entorno de trabajo ordenado.

6. **Ejecución Independiente de Acciones:**
   - También puedes ejecutar cada acción de forma independiente utilizando las siguientes banderas:
     - **Compilar:**  
       ```sh
       make compile
       ```
     - **Ejecutar la Simulación:**  
       ```sh
       make run
       ```
     - **Visualizar en GTKwave:**  
       ```sh
       make view
       ```
     - **Limpiar Archivos:**  
       ```sh
       make clean
       ```

## Análisis de Resultados

A continuación se describen los hallazgos obtenidos de las pruebas realizadas:

- **Figura 1. Primera Prueba:**
  - Antes del primer ciclo de reloj, los valores de los semáforos peatonales son indeterminados, ya que no se han establecido valores inmediatos.
  - Al ingresar al ciclo creciente del reloj, el semáforo para vehículos `a` está en verde, lo que activa el semáforo peatonal `a`.

- **Figura 2. Segunda Prueba:**
  - Se comprobó que si ambos semáforos para vehículos se encuentran en verde, ninguno de los semáforos peatonales se activa para evitar situaciones peligrosas.
  - Antes de que el semáforo `a` cambie a verde, pasa por amarillo; en el instante en que se detecta el cambio, el semáforo
