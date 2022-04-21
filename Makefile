INCLUDE_FILES = include/MagSampleFetcher_cpp/src/mag_sample*.cpp include/MagSampleFetcher_cpp/include/BRAM-uio-driver/src/bram_uio.cpp include/MagSampleFetcher_cpp/include/PL-Mag-Sensor/ip/MagSampleFetcher/drivers/MagSampleFetcher_v1_0/src/*.c
MAIN_FILE = src/main.cpp
CC = g++
OBJ = mag-sample-acquisition

all: 
	$(CC) -o $(OBJ) $(MAIN_FILE) $(INCLUDE_FILES)

clean:
	rm -f $(OBJ)