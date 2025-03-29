# Proyectos de Verilog - Curso de Verilog

## Descripción General

Este repositorio contiene diversos proyectos desarrollados en Verilog como parte del Curso de Verilog. Cada proyecto aborda aspectos específicos del diseño y simulación de sistemas digitales, demostrando la aplicación práctica de conceptos teóricos. En este repositorio se incluyen, entre otros, los siguientes proyectos destacados:

- **Proyecto de Simulación del Protocolo SPI en Verilog:**  
  Implementa un controlador SPI que permite la comunicación entre un master y dos slaves, realizando la transmisión de 16 bits y validando el correcto envío y recepción de datos.

- **Proyecto de Control de Semáforos Peatonales en Verilog:**  
  Desarrolla un controlador para semáforos peatonales que coordina su activación de forma segura junto a los semáforos para vehículos, evitando situaciones de riesgo para los peatones.

- **Proyecto de Calculadora en Verilog:**  
  Diseña una calculadora de 8 bits capaz de realizar operaciones básicas (suma, resta, multiplicación y left shift) controlada por un reloj, señales de habilitación y reinicio. Además, se compara el diseño original con el sintetizado utilizando la librería `cmos_cells`.

- **Otros Proyectos:**  
  Además de los proyectos mencionados, este repositorio contiene otros laboratorios y prácticas que exploran diferentes áreas del diseño digital, cada uno con su propio Makefile, testbenches y documentación de resultados.

## Requisitos

Para compilar y simular los proyectos, asegúrate de tener instalados:
- [Icarus Verilog](http://iverilog.icarus.com/)
- [GTKwave](http://gtkwave.sourceforge.net/)
- `make`

## Estructura del Repositorio

La organización del repositorio es la siguiente:
- **Carpetas de Proyectos:**  
  Cada proyecto se encuentra en su propia carpeta (por ejemplo, `Tarea 3`, `Calculadora`, etc.) y contiene:
  - Archivos Verilog (`.v`).
  - Testbenches para la verificación del diseño.
  - Makefile para automatizar la compilación, simulación y limpieza.

- **Documentación:**  
  Cada proyecto cuenta con su propio README que detalla su funcionamiento, ejecución, análisis de resultados y conclusiones.

## Instrucciones de Uso General

1. **Clonar o Descargar el Repositorio:**
   ```sh
   git clone https://github.com/brendaromeros/Curso_de_verilog.git
   ```

2. **Navegar a la Carpeta del Proyecto Deseado:**
   - Por ejemplo, para el proyecto de Tarea 3 (que puede incluir el proyecto de semáforos o el de SPI):
     ```sh
     cd Curso_de_verilog/Tarea\ 3
     ```

3. **Ejecutar el Comando `make`:**
   ```sh
   make
   ```
   - Este comando compila el proyecto, ejecuta la simulación y genera el archivo `.vcd` para analizar los resultados con GTKwave.

4. **Ejecutar Acciones Específicas:**
   - Para compilar, simular, visualizar o limpiar archivos de forma independiente, se pueden utilizar:
     - **Compilar:** `make compile`
     - **Ejecutar la simulación:** `make run`
     - **Visualizar en GTKwave:** `make view`
     - **Sintetizar (si aplica):** `make synth`
     - **Generar imágenes (JPG/SVG):** `make show_jpg` y `make show_svg`
     - **Limpiar archivos temporales:** `make clean`

## Conclusiones

Estos proyectos demuestran la versatilidad de Verilog en el diseño de sistemas digitales, abarcando desde protocolos de comunicación y control de semáforos hasta la implementación de operaciones matemáticas básicas. Cada proyecto ha sido cuidadosamente probado y documentado, permitiendo validar su correcto funcionamiento y explorar áreas de mejora.

## Autor

Brenda Romero Solano

## Licencia

Este repositorio está bajo la licencia [MIT](https://opensource.org/licenses/MIT).
```
