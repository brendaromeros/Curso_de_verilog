# Makefile para compilar y ejecutar .v con Gtkwave en Windows y Linux

# Comprobación del sistema operativo
ifeq ($(OS),Windows_NT)
    # Configuraciones para Windows
    COMPILE_CMD = iverilog -o testbench.vvp .\testbench.v
	VPP = vvp .\testbench.vvp
    GTKWAVE_CMD = gtkwave testbench.vcd
	RM = del
	
else
    # Configuraciones para Linux
    COMPILE_CMD = iverilog -o testbench.vvp testbench.v
	VPP = vvp testbench.vvp
    GTKWAVE_CMD = gtkwave testbench.vcd
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
	$(RM) -f testbench.vvp testbench.vcd

.PHONY: all clean compile view run