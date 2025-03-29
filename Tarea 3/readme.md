# Proyecto de Simulación del Protocolo SPI en Verilog

## Descripción

Este proyecto implementa un controlador que simula el protocolo SPI utilizando Verilog. Se realizaron diversas pruebas para verificar la correcta comunicación entre un `master` y dos `slaves`. El diseño permite la transmisión de 16 bits de datos y la verificación de la comunicación a través de diversas etapas de simulación.

## Ejecución del Programa

Para utilizar el programa, sigue estos pasos:

1. **Ubicarte en la Carpeta del Proyecto:**
   - Abre una terminal y navega hasta la carpeta del proyecto:
     ```sh
     cd Curso_de_verilog/Tarea\ 3
     ```

3. **Ejecutar el Comando `make`:**
   - Ejecuta:
     ```sh
     make
     ```
   - Este comando compila el proyecto, revisa los archivos en busca de problemas y genera el archivo `.vcd` necesario para la simulación.

4. **Visualización Automática:**
   - Una de las ventajas es que `make` abre automáticamente GTKwave, una herramienta de visualización que permite inspeccionar y analizar el comportamiento de los circuitos simulados.

5. **Limpieza del Proyecto:**
   - `make` se encarga de eliminar los archivos temporales generados durante la compilación y simulación, manteniendo el entorno de trabajo ordenado.

6. **Acciones Independientes:**
   - Si lo prefieres, cada acción puede ejecutarse de forma independiente usando las siguientes banderas:
     - **Compilar:**  
       ```sh
       make compile
       ```
     - **Ejecutar la simulación:**  
       ```sh
       make run
       ```
     - **Visualizar en GTKwave:**  
       ```sh
       make view
       ```
     - **Limpiar archivos:**  
       ```sh
       make clean
       ```

## Análisis de Resultados

A continuación, se describen los principales hallazgos de las pruebas realizadas:

- **Figura 1. Configuración Inicial:**  
  Al aplicar un valor de `1` en la entrada `reset`, el controlador comienza en estado de reposo. Con `slave_numb` en `1`, se activa el esclavo 1, listo para recibir datos.

- **Figura 2. Datos Recibidos Correctamente en el Slave 1:**  
  Tras recibir un dato en `dato_in`, el `master` inicia la transmisión al `slave` seleccionado. Un contador se encarga de gestionar la transferencia de los 16 bits, iniciando desde el bit más significativo hasta llegar al bit 16, lo que confirma la correcta transmisión.

- **Figura 3. Recepción de los Datos Guardados en el Slave 1:**  
  El `slave` reenvía los datos almacenados en la variable `mosi`, los cuales son capturados en la variable `miso` del `master`. Se observa que la señal `cs_1` se restablece a su estado alto una vez finalizada la transmisión.

- **Figura 4 y Figura 5. Funcionamiento del Slave 2:**  
  Se realizaron pruebas adicionales para verificar el funcionamiento del `slave_2`, confirmando que el controlador puede gestionar múltiples `slaves` de forma correcta.

## Conclusiones

Después de analizar los resultados de las pruebas se concluye que:
- El controlador funciona correctamente simulando el protocolo SPI.
- La comunicación entre el `master` y ambos `slaves` se realiza de forma precisa.
- Los datos se transmiten y se reciben correctamente, asegurando la integridad de la información.
- La implementación permite la verificación de la transmisión de 16 bits y la correcta activación de los `slaves`.

## Autor

Brenda Romero Solano

## Licencia

Este proyecto está bajo la licencia [MIT](https://opensource.org/licenses/MIT).
