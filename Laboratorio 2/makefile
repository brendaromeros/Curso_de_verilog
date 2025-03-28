# Makefile para compilar y ejecutar .v con Gtkwave en Windows y Linux

# Comprobación del sistema operativo
ifeq ($(OS),Windows_NT)
    # Configuraciones para Windows
    COMPILE_CMD = iverilog -o cajero_testbench.vvp .\cajero_testbench.v
	VPP = vvp .\cajero_testbench.vvp
    GTKWAVE_CMD = gtkwave cajero_testbench.vcd
	RM = del
	
else
    # Configuraciones para Linux
    COMPILE_CMD = iverilog -o cajero_testbench.vvp cajero_testbench.v
	VPP = vvp cajero_testbench.vvp
    GTKWAVE_CMD = gtkwave cajero_testbench.vcd
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
	$(RM) -f cajero_testbench.vvp cajero_testbench.vcd cajero_sintesis.svg cajero_sintesis.jpg cajero_sintesis.dot
synth:
	yosys -p " \
        read_verilog cajero.v; \
        hierarchy -check -top cajero; \
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
        write_verilog cajero_sintesis.v \
    "

show_svg:
	yosys -p " \
        read_verilog cajero_sintesis.v; \
        show -format svg -prefix cajero_sintesis \
    "

show_jpg:
	yosys -p " \
        read_verilog cajero_sintesis.v; \
        show -format jpg -prefix cajero_sintesis \
    "
.PHONY: all clean compile view run synth show_svg show_jpg
