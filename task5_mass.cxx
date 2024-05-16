#include <RtypesCore.h>
#include <TCanvas.h>
#include <TChain.h>
#include <TH1D.h>
#include <TROOT.h>
#include <algorithm>
#include <cstdlib>

void task5_mass(char const *fin, const Int_t bins) {
    // Open a tree
    auto chIn = new TChain("ntK0");
    chIn->Add(fin);

    // Get all masses
    typedef Float_t Mass_t;
    Long64_t entries = chIn->GetEntries();
    Mass_t *masses = (Mass_t *)calloc(sizeof(Double_t), entries), tmpmass;
    chIn->SetBranchAddress("massK0", &tmpmass);
    for (Long64_t i = 0; i < entries; ++i) {
        chIn->GetEntry(i + 1);
        masses[i] = tmpmass;
    }
    Mass_t max_mass = *std::max_element(masses, masses + entries),
           min_mass = *std::min_element(masses, masses + entries);

    // Create a histogram
    auto hist = new TH1F("hist", "K0-short mass", bins, min_mass, max_mass);
    for (Long64_t i = 0; i < entries; ++i) {
        hist->Fill(masses[i]);
    }

    // Draw the histogram
    gROOT->Reset();
    gROOT->SetStyle("Plain");
    auto canv = new TCanvas("c", "c");
    canv->cd(1);
    hist->Draw();

    // Free the memory
    free(masses);
}
