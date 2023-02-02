CC = g++ -g
OBJS = main.o Data.o Mergesort.o
EXE  = teste

CFLAGS = -Wall

all: $(EXE)

$(EXE): $(OBJS)
	$(CC) -o $(EXE) $(OBJS) $(CFLAGS) 

Data.o: Data.cpp Data.hpp
	$(CC) -c $< $(CFLAGS)

Mergesort.o: Mergesort.cpp Mergesort.hpp
	$(CC) -c $< $(CFLAGS)	

main.o: main.cpp
	$(CC) -c $< $(CFLAGS)

clean:
	@ rm -f $(EXE) $(OBJS)

clear: clean

.PHONY: all clean
