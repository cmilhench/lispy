# the compiler: gcc for C program, define as g++ for C++
CC = gcc

# compiler flags:
#  -g    adds debugging information to the executable file
#  -Wall turns on most, but not all, compiler warnings
CFLAGS = -std=c99 -Wall

# define any directories containing header files other than /usr/include
# something like: -L../include
INCLUDES =

# define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like: -L../lib
LFLAGS =

# define the C source files
SRCS = $(wildcard *.c)
#SRCS = $(shell find . -name *.c)

# define the C object files
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
OBJS = $(SRCS:.c=.o)

# the build target executable:
TARGET = ./bin/lispy

.PHONY: clean

# typing 'make' will invoke the first target entry in the file
# (in this case the default target entry)
# you can name this target entry anything, but "default" or "all"
# are the most commonly used names by convention
default: $(TARGET)
	@echo compiled!

$(TARGET): $(OBJS)
	@$(CC) $(CFLAGS) $(INCLUDES) -o $@ $^ $(LFLAGS)

# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of
# the rule(a .c file) and $@: the name of the target of the rule (a .o file)
# (see the gnu make manual section about automatic variables)
.c.o:
	@$(CC) $(CFLAGS) $(INCLUDES) -c $<  -o $@

# To start over from scratch, type 'make clean'.  This
# removes the executable file, as well as old .o object
# files and *~ backup files:
clean:
	@$(RM) $(TARGET) $(OBJS) *~
	@echo cleaned!

