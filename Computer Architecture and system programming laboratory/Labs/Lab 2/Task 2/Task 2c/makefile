# All Targets
all: menu_map

# Tool invocations
# Executable "menu_map" depends on the files menu_map.o
menu_map: menu_map.o 
	gcc -m32 -g -Wall -o menu_map menu_map.o

# Depends on the source and header files
menu_map.o: menu_map.c
	gcc -g -Wall -m32  -c -o menu_map.o menu_map.c

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o menu_map
