# Proyecto de Calculadora en Verilog

## Descripción

En este trabajo se diseñó un módulo que permite realizar operaciones matemáticas básicas (suma, resta, multiplicación y left shift) controlado por un reloj, señales de habilitación y reinicio. El usuario puede seleccionar el modo de operación mediante las entradas del módulo, y el resultado se genera en la salida correspondiente.

Para verificar el correcto funcionamiento de la calculadora se diseñaron pruebas específicas a través del archivo `calculadora_tester.v`. Este testbench inicializa los valores de entrada, activa números aleatorios en los operandos y utiliza el comando `$display` para previsualizar los resultados en la consola.

## Ejecución del Programa

Para utilizar el programa, sigue estos pasos:

1.  **Ubicarte en la Carpeta del Proyecto:**
   - Abre la terminal y navega hasta la carpeta de la tarea:
     ```sh
     cd ruta/al/proyecto
     ```
   - Nota: Si usas Windows, se recomienda utilizar OSS CAD SUITE y abrir la terminal a través de `start.bat`. Asegúrate de que la dirección del Makefile esté agregada a la variable de entorno.

2. **Ejecutar el Comando `make`:**
   - Ejecuta:
     ```sh
     make
     ```
   - Este comando compila automáticamente el proyecto, revisa los archivos en busca de errores y genera el archivo `.vcd` para el análisis y visualización de la simulación, así como el archivo sintetizado que muestra las compuertas implementadas.

3. **Visualización Automática:**
   - `make` abre automáticamente GTKwave para que puedas inspeccionar los waveforms y entender el comportamiento del sistema.

4. **Limpieza del Proyecto:**
   - Para eliminar los archivos temporales generados durante la compilación y ejecución:
     ```sh
     make clean
     ```

5. **Acciones Independientes:**
   - También puedes ejecutar cada acción de forma independiente:
     - **Compilar:**  
       ```sh
       make compile
       ```
     - **Ejecutar la Simulación y Generar .vcd:**  
       ```sh
       make run
       ```
     - **Visualizar en GTKwave:**  
       ```sh
       make view
       ```
     - **Sintetizar el Módulo (DUT):**  
       ```sh
       make synth
       ```
     - **Generar Imágenes (JPG y SVG):**  
       ```sh
       make show_jpg
       make show_svg
       ```

> Para comprobar la salida del código sintetizado, se puede usar el mismo testbench que se encuentra en la carpeta de la tarea, eliminando los símbolos de comentarios en los `include` que correspondan y comentando el que contiene el `calculadora.v` original.

## Creación del Código

Se implementó una calculadora de 8 bits que recibe hasta dos números. El módulo, controlado por un reloj y señales `enb` (habilitación) y `reset`, utiliza un proceso que se dispara en cada flanco positivo del reloj. Cuando `enb` está activado, se evalúa la entrada `modo` mediante un `case` que determina la operación a realizar:
- **00:** Suma
- **01:** Resta
- **10:** Multiplicación
- **11:** Left Shift

Se definieron parámetros con los nombres y valores correspondientes para facilitar la comprensión del código. Además, se implementó el `$display` para mostrar el resultado en la consola durante las pruebas.

## Análisis de Resultados

A continuación se resumen los hallazgos de las pruebas realizadas:

- **Figura 1. Inicialización de las Señales:**
  - Se aplicó la señal `reset` para inicializar el DUT, estableciendo todas las señales a 0.

- **Figura 2 y Figura 3. Pruebas de Suma:**
  - Durante 20 ns de simulación se verificó que, con el modo `00`, la suma de dos números se realiza correctamente.
  - Se realizaron dos pruebas con diferentes valores, ambas mostrando el resultado esperado.

- **Figura 4 y Figura 5. Pruebas de Resta:**
  - Al cambiar el modo a `01`, se comprobó que la operación de resta arroja el resultado correcto en ambas pruebas.

- **Figura 6 y Figura 7. Pruebas de Multiplicación:**
  - Con el modo `10`, se ingresaron números aleatorios para verificar la multiplicación, obteniéndose resultados correctos.
  - Se incluyó un caso límite para evitar un posible acarreo.

- **Figura 8 y Figura 9. Pruebas de Left Shift:**
  - Al seleccionar el modo `11`, la calculadora desplaza el número a la izquierda, rellenando con ceros. Se observaron 3 ceros en la salida, junto con los dígitos más significativos del operando.

- **Figura 10, Figura 11 y Figura 12. Síntesis y Comparación:**
  - Se comparó el diseño original con el sintetizado usando la librería `cmos_cells`.
  - Aunque se detectó un cambio en el valor de la señal `c` durante el primer ciclo de reloj en la simulación sintetizada, dicho cambio no afectó el comportamiento global del sistema.

## Conclusiones

- La calculadora de 8 bits se comporta de manera consistente en todas las operaciones evaluadas (suma, resta, multiplicación y left shift).
- La inicialización mediante `reset` garantiza un estado estable al inicio de la simulación.
- La comparación entre el diseño original y el sintetizado confirma que la síntesis no compromete la integridad funcional, a pesar de un cambio transitorio observado en la primera fase.
- La implementación de pruebas específicas y el uso de `$display` permiten una verificación detallada del correcto funcionamiento del sistema.

## Autor

Brenda Romero Solano

## Licencia

Este proyecto está bajo la licencia [MIT](https://opensource.org/licenses/MIT).
