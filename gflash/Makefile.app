VPATH=..

CFLAGS = -Wall -I../..
CXXFLAGS = -Wall -DUSE_WX -I. -I../..

OBJECTS_CLI = gflash_cli.o


#OBJECTS_GUI = gflash_gui.o

GFLASH_LIB = gflash_lib.o

OBJECTS = $(OBJECTS_CLI) $(OBJECTS_GUI) $(GFLASH_LIB)

LIBS += $(GFLASH_LIB)
LIBS += -lusb-1.0

ifeq ($(BUILD),WIN32)
AR = i686-w64-mingw32-ar
CC = i686-w64-mingw32-gcc
CXX = i686-w64-mingw32-g++
WXCONFIG = i686-wx-config
BF = -win32
CFLAGS += -I/usr/local/i686-w64-mingw32/include
CXXLAGS += -I/usr/local/i686-w64-mingw32/include -fno-rtti -fno-exceptions
LIBS += -L/usr/local/i686-w64-mingw32/lib -lsetupapi -lole32 -ladvapi32
else
WXCONFIG=wx-config
endif

ifeq ($(DEBUG),YES)
        CXXFLAGS+= `$(WXCONFIG) --cxxflags --debug=yes` -ggdb
	WXLIBS= `$(WXCONFIG) --libs --debug=yes`
else
        CXXFLAGS+= `$(WXCONFIG) --cxxflags`
	WXLIBS= `$(WXCONFIG) --libs`
endif

$(APP): $(OBJECTS)
	$(CC) -o $(APP)_cli $(OBJECTS_CLI) $(LIBS)
#	$(CC) -o gmod gmod.o
#	$(CXX) -o $(APP)_gui $(OBJECTS_GUI) $(LIBS) $(WXLIBS)

clean:
	rm -f *.o $(NAME) core.*
