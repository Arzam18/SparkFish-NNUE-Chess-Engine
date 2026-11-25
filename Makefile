CXX      := g++
CXXFLAGS := -std=c++20 -O3 -flto=auto -DNDEBUG -Wall -pthread
LDFLAGS  := -flto=auto -pthread -static-libstdc++ -static-libgcc

# 如果当前目录存在 SparkfishV4.nnue，自动开启单文件内嵌
ifneq ($(wildcard SparkfishV4.nnue),)
CXXFLAGS += -DSPARKFISH_EMBED_NNUE
endif

.PHONY: all avx2 avx512 native clean

all: avx2

avx2:
	$(CXX) $(CXXFLAGS) -mavx2 -mbmi2 -mpopcnt main.cpp -o sparkfish-4.0-linux-avx2 $(LDFLAGS)

avx512:
	$(CXX) $(CXXFLAGS) -mavx512f -mavx512bw -mavx512vl -mavx512dq -mbmi2 -mpopcnt main.cpp -o sparkfish-4.0-linux-avx512 $(LDFLAGS)

native:
	$(CXX) $(CXXFLAGS) -march=native main.cpp -o sparkfish-4.0-linux-native $(LDFLAGS)

clean:
	rm -f sparkfish-4.0-linux-*
