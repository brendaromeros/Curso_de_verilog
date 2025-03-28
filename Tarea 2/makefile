# Makefile para compilar y ejecutar .v con Gtkwave en Windows y Linux

# Comprobación del sistema operativo
ifeq ($(OS),Windows_NT)
    # Configuraciones para Windows
    COMPILE_CMD = iverilog -o calculadora_testbench.vvp .\calculadora_testbench.v
	VPP = vvp .\calculadora_testbench.vvp
    GTKWAVE_CMD = gtkwave calculadora_testbench.vcd
	RM = del
else
    # Configuraciones para Linux
    COMPILE_CMD = iverilog -o calculadora_testbench.vvp calculadora_testbench.v
	VPP = vvp calculadora_testbench.vvp
    GTKWAVE_CMD = gtkwave calculadora_testbench.vcd
	RM = rm
endif

all: compile run view synth clean

compile:
	$(COMPILE_CMD)		
run:
	$(VPP)
view:
	$(GTKWAVE_CMD)
clean:
	$(RM) -f calculadora_testbench.vvp calculadora_testbench.vcd calculadora_sintesis.svg calculadora_sintesis.jpg calculadora_sintesis.dot
synth:
	yosys -p " \
        read_verilog calculadora.v; \
        hierarchy -check -top calculadora; \
        proc; \
        opt; \
        fsm; \
        opt; \
        memory; \
        opt; \
        techmap; \
        opt; \
        dfflibmap -liberty cmos_cells.lib; \
        abc -liberty cmos_cells.lib; \
        clean; \
        write_verilog calculadora_sintesis.v \
    "

show_svg:
	yosys -p " \
        read_verilog calculadora_sintesis.v; \
        show -format svg -prefix calculadora_sintesis \
    "
    
show_jpg:
	yosys -p " \
        read_verilog calculadora_sintesis.v; \
        show -format jpg -prefix calculadora_sintesis \
    "
.PHONY: all clean compile view run synth show_svg show_jpg
