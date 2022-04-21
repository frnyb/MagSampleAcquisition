#include "../include/MagSampleFetcher_cpp/src/mag_sample_fetcher.h"

#include <iostream>

int main(int argc, char *argv[]) {
    MagSampleFetcher msf(1, 8192);

    std::vector<MagSample> samples;

    if (argc == 2) {
        unsigned int n_periods = std::stoi(argv[1]);

        samples = msf.GetSamples(n_periods);
    } else {
        samples = msf.GetSamples();
    }

    for (int i = 0; i < 12; i++) {
        std::cout << "Time_ch" << std::to_string(i) << "\t";
    }

    for (int i = 0; i < 12; i++) {
        std::cout << "Sample_ch" << std::to_string(i) << "\t";
    }

    std::cout << std::endl;

    for (int i = 0; i < samples.size(); i++) {
        for (int j = 0; j < 12; j++) {
            std::cout << std::to_string(samples[i][j].time_offset) << "\t";

            if (j==2 || j==5 || j==8 ) {
                std::cout << "\t";
            }
        }

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