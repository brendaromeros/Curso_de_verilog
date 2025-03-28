# Makefile para compilar y ejecutar .v con Gtkwave en Windows y Linux

# Comprobación del sistema operativo
ifeq ($(OS),Windows_NT)
    # Configuraciones para Windows
    COMPILE_CMD = iverilog -o calle_testbench.vvp .\calle_testbench.v
	VPP = vvp .\calle_testbench.vvp
    GTKWAVE_CMD = gtkwave calle_testbench.vcd
	RM = del
	
else
    # Configuraciones para Linux
    COMPILE_CMD = iverilog -o calle_testbench.vvp calle_testbench.v
	VPP = vvp calle_testbench.vvp
    GTKWAVE_CMD = gtkwave calle_testbench.vcd
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
	$(RM) -f calle_testbench.vvp calle_testbench.vcd

.PHONY: all clean compile view run