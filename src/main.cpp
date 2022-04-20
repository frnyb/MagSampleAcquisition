#include "../include/MagSampleFetcher_cpp/src/mag_sample_fetcher.h"

#include <iostream>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        std::cout << "Please pass the number of periods to sample as argument" << std::endl;
        return 1;
    }

    unsigned int n_periods = std::stoi(argv[1]);

    MagSampleFetcher msf(1, 8192);

    std::vector<MagSample> samples = msf.GetSamples(n_periods);

    for (int i = 0; i < samples.size(); i++) {
        for (int j = 0; j < 12; j++) {
            std::cout << std::to_string(samples[i][j].data) << "\t";

            if (j==2 || j==5 || j==8 ) {
                std::cout << "\t";
            }
        }

        std::cout << std::endl;
    }




    return 0;
}