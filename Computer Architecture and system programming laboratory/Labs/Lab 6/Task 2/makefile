# All Targets
all: mypipeline

# Tool invocations
mypipeline: mypipeline.o
	gcc -m32 -g -Wall -o mypipeline mypipeline.o

# Depends on the source and header files
mypipeline.o: mypipeline.c
	gcc -g -Wall -m32  -c mypipeline.c -o mypipeline.o

#tell make that "clean" is not a file name!
.PHONY: clean

#Clean the build directory
clean: 
	rm -f *.o mypipeline
