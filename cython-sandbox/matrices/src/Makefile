# Change the compiler (e.g. icc,gcc,clang) in the following variable,
# or provide an argument as "make CC=gcc". If provided, the argument will
# cause the following CC variable definition to be ignored.
CC = icc

# common flags, libraries
CFLAGS = -std=c11 -O3
CFLAGS += -Wall
LIBS = -lm

ifeq ($(CC),icc)
  CFLAGS += -DICC -qopenmp
  CFLAGS += -no-prec-div -restrict -ipo -inline-calloc -qopt-calloc -no-ansi-alias
  CFLAGS += -xCORE-AVX2
  #CFLAGS += -qopenmp-link=static
  #CFLAGS += -static-intel -wd10237
  #CFLAGS += -prof-gen
  #CFLAGS += -prof-use
  #CFLAGS += -no-vec -no-simd
  #CFLAGS += -qopt-report=4 -qopt-report-phase=vec
  #CFLAGS += -w3
  #CFLAGS += -debug

else ifeq ($(CC),clang)
  CFLAGS += -Xclang -fopenmp
  CFLAGS += -Wno-unknown-pragmas
  LIBS += -lomp

else ifeq ($(CC),gcc)
  CFLAGS += -fopenmp
  CFLAGS += -Wno-unknown-pragmas
else
  CFLAGS += -fopenmp
endif


all: main clean

clean:
	rm *.o

OBJ = matrices.o allocate.o 

main: main.o $(OBJ)
	$(CC) $(CFLAGS) $^ -o $@ $(LIBS)
	mv $@ ../bin

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@