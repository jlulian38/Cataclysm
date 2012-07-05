# comment these to toggle them as one sees fit.
# WARNINGS will spam hundreds of warnings, mostly safe, if turned on
# DEBUG is best turned on if you plan to debug in gdb -- please do!
# PROFILE is for use with gprof or a similar program -- don't bother generally
#WARNINGS = -Wall -Wextra -Wno-switch -Wno-sign-compare -Wno-missing-braces -Wno-unused-parameter -Wno-char-subscripts
#DEBUG = -g
#PROFILE = -pg

ODIR = obj
ODIRT = objt
DDIR = .deps
DDIRT = .depst

TARGET = cataclysm
TARGET_TILES = catatiles

OS  = $(shell uname -o)
CXX = g++

CFLAGS = $(WARNINGS) $(DEBUG) $(PROFILE)

ifeq ($(OS), Msys)
LDFLAGS = -static -lpdcurses
else 
LDFLAGS = -lncurses
endif

SOURCES = $(wildcard *.cpp)
_OBJS = $(SOURCES:.cpp=.o)
OBJS = $(patsubst %,$(ODIR)/%,$(_OBJS))
OBJST = $(patsubst %,$(ODIRT)/%,$(_OBJS))

$(TARGET): $(ODIR) $(DDIR) $(OBJS)
	$(CXX) -o $(TARGET) $(CFLAGS) $(OBJS) $(LDFLAGS) 

all: $(TARGET) $(TARGET_TILES)
	@

tiles: $(TARGET_TILES)
	@

$(TARGET_TILES): $(ODIRT) $(DDIRT) $(OBJST)
	$(CXX) -o $(TARGET_TILES) $(CFLAGS) $(OBJST) -lGL

$(ODIR):
	mkdir $(ODIR)

$(DDIR):
	@mkdir $(DDIR)

$(ODIR)/%.o: %.cpp
	$(CXX) $(CFLAGS) -c $< -o $@

$(ODIRT):
	mkdir $(ODIRT)

$(DDIRT):
	@mkdir $(DDIRT)

$(ODIRT)/%.o: %.cpp
	$(CXX) $(CFLAGS) -DTILES -c $< -o $@

clean:
	rm -f $(TARGET) $(ODIR)/*.o
	rm -f $(TARGET_TILES) $(ODIRT)/*.o

-include $(SOURCES:%.cpp=$(DEPDIR)/%.P)

