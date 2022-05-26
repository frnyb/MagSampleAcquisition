//#include "../include/MagSampleFetcher_cpp/src/mag_sample_fetcher.h"
//#include "../include/SlidingWindowMagSampleFetcher_cpp/src/sliding_window_mag_sample_fetcher.h"
#include "../include/BRAM-uio-driver/src/bram_uio.h"

#include <iostream>

#define 	N_PERIODS				10
#define 	N_SAMPLES_PER_PERIOD	8
#define 	N_CHANNELS				12
#define		N_SAMPLES				N_PERIODS*N_SAMPLES_PER_PERIOD

int main(int argc, char *argv[]) {
	BRAM bram(0, 8192);

    int n_periods = 10;

    if (argc > 1) {
        n_periods = std::stoi(argv[1]);
    }

    bram[1] = (uint32_t)n_periods;

	bram[0] = 1;

	while(bram[0] == 1) ;

    uint32_t n_samples = bram[2];

    std::cout << std::endl;

    for (int i = 0; i < n_samples; i++) {
        for (int j = 0; j < 12; j++) {
            std::cout << std::to_string(bram[3+i*N_CHANNELS+j]) << "\t";
        }

        std::cout << std::endl;
    }

    return 0;
}
