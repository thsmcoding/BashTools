#This is a template for a usual Makefile
EX := main
SOURCES := $(wildcard *.cpp)
OBJFILES :=$(pathsubst %.c, %.o, $(SOURCES))
HEADERS := $(wildcard *.hpp)
HEADERS += $(wildcard *.h)
CC = gcc -Wall

$(EX) : $(OBJFILES)
	$(CC) -o $(EX) $(OBJFILES)

$(OBJFILES) : $(SOURCES) 
	$(CC) -c $(SOURCES)

.PHONY : clean
clean:
	rm -rf $(OBJFILES)
