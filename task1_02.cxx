#include <RtypesCore.h>
#include <TFile.h>
#include <TTree.h>
#include <cstdio>

#define MAX_TRACKS 250
#define TRACKS_COUNT "Trk_ntracks"
#define MOMENTUM_X "Trk_px"
#define MOMENTUM_Y "Trk_py"
#define MOMENTUM_Z "Trk_pz"
#define CHARGE "Trk_charge"

void print_event(TTree *tree, Int_t evt_no) {
    Float_t pxs[MAX_TRACKS]; // momentum x array
    Float_t pys[MAX_TRACKS]; // momentum y array
    Float_t pzs[MAX_TRACKS]; // momentum z array
    Float_t qs[MAX_TRACKS];  // charges array

    Int_t positive_charges = 0;
    Int_t negative_charges = 0;
    Int_t tracks_count;

    // set addresses
    tree->SetBranchAddress(MOMENTUM_X, pxs);
    tree->SetBranchAddress(MOMENTUM_Y, pys);
    tree->SetBranchAddress(MOMENTUM_Z, pzs);
    tree->SetBranchAddress(CHARGE, qs);
    tree->SetBranchAddress(TRACKS_COUNT, &tracks_count);

    // get the event data
    tree->GetEntry(evt_no);

    // print data
    printf("Event no %d:\n", evt_no);
    for (Int_t track_i = 0; track_i < tracks_count; ++track_i) {
        printf("|\tTrack no %2d: momentum = [%7.3f, %7.3f, %7.3f], charge = "
               "%10.2fe\n",
               track_i, pxs[track_i], pys[track_i], pzs[track_i], qs[track_i]);
        if (qs[track_i] > 0) {
            positive_charges += 1;
        } else if (qs[track_i] < 0) {
            negative_charges += 1;
        }
    }
    printf("%d tracks total, charge signs: %d/%d\n\n", tracks_count,
           positive_charges, negative_charges);
}

void task1_02(char const *fname, char const *tname) {
    auto file = TFile::Open(fname);
    auto tree = file->Get<TTree>(tname);

    print_event(tree, 1);
    print_event(tree, 2);
}
