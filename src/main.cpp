#include "../include/MagSampleFetcher_cpp/src/mag_sample_fetcher.h"

#include <iostream>

int main(int argc, char *argv[]) {
    MagSampleFetcher msf(1, 8192);

    std::vector<MagSample> samples = msf.GetSamples(1);

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