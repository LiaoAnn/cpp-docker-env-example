# Makefile variables
CXX := g++
CXXFLAGS := -std=c++11 -Wall
LDFLAGS := -lboost_system -lboost_filesystem -lwebsocketpp

# Boost library paths (updated based on Dockerfile)
BOOST_INCLUDE := /usr/include
BOOST_LIB := /usr/lib

# WebSocketpp library paths
WEBSOCKETPP_INCLUDE := /usr/include/websocketpp

# Source files
SRCS := $(wildcard src/*.cpp)
OBJS := $(patsubst src/%.cpp, build/%.o, $(SRCS))

# Target executable
TARGET := MyExecutable

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -L$(BOOST_LIB) -L$(WEBSOCKETPP_INCLUDE) $^ -o $@ $(LDFLAGS)

build/%.o: src/%.cpp
	$(CXX) $(CXXFLAGS) -I$(BOOST_INCLUDE) -I$(WEBSOCKETPP_INCLUDE) -c $< -o $@

clean:
	rm -rf $(OBJS) $(TARGET)
