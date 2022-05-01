INCLUDE_FILES = include/SlidingWindowMagSampleFetcher_cpp/src/*.cpp include/SlidingWindowMagSampleFetcher_cpp/include/BRAM-uio-driver/src/bram_uio.cpp include/SlidingWindowMagSampleFetcher_cpp/include/PL-Mag-Sensor/ip/SlidingWindowMagSampleFetcher/drivers/SlidingWindowMagSampleFetcher_v1_0/src/*.c
MAIN_FILE = src/main.cpp
CC = g++
OBJ = mag-sample-acquisition

all: 
	$(CC) -o $(OBJ) $(MAIN_FILE) $(INCLUDE_FILES)

	echo "Finished building"

clean:
	rm -f $(OBJ)