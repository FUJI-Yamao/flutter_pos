CC = gcc
SHFLGS = -fPIC
SHOPT = -shared
SIILIB = libsii.a

MAKEFILE = Makefile

#
#
TARGET = ../libprinter.so.1.0.0

#
#
#DRVINC = -I./ -I../inc

#
#
SRCS = PrinterAPI.c

HDRS = PrinterAPI.h

#
#
all: $(SRCS) $(MAKEFILE) $(MAKEFILECONFIG) $(HDRS)
	$(CC) $(SHOPT) $(SHFLGS) $(DRVINC) -o $(TARGET) $(SRCS) $(SIILIB)

clean :
	/bin/rm -f $(OBJS) $(TARGET)

