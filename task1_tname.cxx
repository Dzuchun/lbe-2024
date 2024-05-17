#include <TFile.h>

void task1_tname(char const *fname) {
    auto fin = TFile::Open(fname);
    fin->ls();
}
