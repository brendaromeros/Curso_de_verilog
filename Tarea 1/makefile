# Makefile para compilar y ejecutar .v con Gtkwave en Windows y Linux

# Comprobación del sistema operativo
ifeq ($(OS),Windows_NT)
    # Configuraciones para Windows
    COMPILE_CMD = iverilog -o lavadora_testbench.vvp .\lavadora_testbench.v
	VPP = vvp .\lavadora_testbench.vvp
    GTKWAVE_CMD = gtkwave Lavadora_testbench.vcd
	RM = del
	
else
    # Configuraciones para Linux
    COMPILE_CMD = iverilog -o lavadora_testbench.vvp lavadora_testbench.v
	VPP = vvp lavadora_testbench.vvp
    GTKWAVE_CMD = gtkwave Lavadora_testbench.vcd
	RM = rm

endif

all: compile run view clean

compile:
	$(COMPILE_CMD)		
run:
	$(VPP)
view:
	$(GTKWAVE_CMD)

clean:
	$(RM) -f lavadora_testbench.vvp Lavadora_testbench.vcd

.PHONY: all clean compile view run
