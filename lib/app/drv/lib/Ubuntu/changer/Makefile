CC = gcc
SHFLGS = -fPIC
SHOPT = -shared

MAKEFILE = Makefile

#
#
TARGET = libChangerAPI.so

#
#
DRVINC = -I./ -I../inc

#
#
SRCS = \
	ChangerAPI.c

HDRS = ChangerAPI.h

#
#
all: $(SRCS) $(MAKEFILE) $(MAKEFILECONFIG) $(HDRS)
	$(CC) $(SHOPT) $(SHFLGS) $(DRVINC) -o $(TARGET) $(SRCS) 

clean :
	/bin/rm -f $(OBJS) $(TARGET)

