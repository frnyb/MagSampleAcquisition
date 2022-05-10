//#include "../include/MagSampleFetcher_cpp/src/mag_sample_fetcher.h"
#include "../include/SlidingWindowMagSampleFetcher_cpp/src/sliding_window_mag_sample_fetcher.h"
#include "../include/BRAM-uio-driver/src/bram_uio.h"

#include <iostream>

#define 	N_PERIODS				10
#define 	N_SAMPLES_PER_PERIOD	8
#define 	N_CHANNELS				12
#define		N_SAMPLES				N_PERIODS*N_SAMPLES_PER_PERIOD

int main(int argc, char *argv[]) {
    //SlidingWindowMagSampleFetcher msf(1, 8192);
	BRAM bram(1, 8192);

	bram[0] = 1;

	while(bram[0] == 1) ;

    std::cout << std::endl;

    for (int i = 0; i < N_SAMPLES; i++) {
        for (int j = 0; j < 12; j++) {
            std::cout << std::to_string(bram[i*N_CHANNELS+j]) << "\t";
        }

        std::cout << std::endl;
    }

    return 0;
}
