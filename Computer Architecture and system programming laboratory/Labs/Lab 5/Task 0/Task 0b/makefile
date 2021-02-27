# All Targets
all: looper

# Tool invocations
# Executable "task0" depends on the files patch.o util.o start.o
looper: looper.o 
	gcc -m32 -g -Wall -o looper looper.o

# Depends on the source and header files
looper.o: looper.c
	gcc -g -Wall -m32  -c looper.c -o looper.o

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o looper
