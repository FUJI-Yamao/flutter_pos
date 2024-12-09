CC = gcc
SHFLGS = -fPIC
SHOPT = -shared

MAKEFILE = Makefile

TARGET = libMultiTmnAPI.so

DRVINC = -I./ -I../inc -I/pj/tprx/src/regs/multi_tmn/include

SRCS = \
	MultiTmnApi.c \
	MultiTmnMem.c

OBJS = \
	MultiTmnApi.o \
	MultiTmnMem.o

# TMN libs
LDFLAGS = -L/pj/tprx/src/regs/multi_tmn/lib

LIBS = -lxml2 -lz -lrt -lpthread -lstdc++

HDRS = MultiTmnAPI.h

all: $(SRCS) $(MAKEFILE) $(MAKEFILECONFIG) $(HDRS)
	$(CC) $(SHFLGS) $(SHOPT) $(DRVINC) $(LDFLAGS) -o $(TARGET) $(SRCS) $(LIBS)

clean : \
 	/bin/rm -f $(OBJS) $(TARGET)

