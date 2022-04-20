#include "../include/MagSampleFetcher_cpp/src/mag_sample_fetcher.h"

#include <iostream>

int main(int argc, char *argv[]) {
    MagSampleFetcher msf(0, 8192);

    std::vector<MagSample> samples = msf.GetSamples(1);

    return 0;
}