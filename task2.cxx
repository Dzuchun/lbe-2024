#include <RtypesCore.h>
#include <TChain.h>
#include <TFile.h>
#include <TNtuple.h>
#include <TTree.h>
#include <TVector3.h>
#include <cstdio>

#define MAX_TRACKS 250
#define TRACKS_COUNT "Trk_ntracks"
#define MOMENTUM_X "Trk_px"
#define MOMENTUM_Y "Trk_py"
#define MOMENTUM_Z "Trk_pz"
#define CHARGE "Trk_charge"

void print_event(TTree *tree_in, Int_t evt_no, TNtuple *tree_out) {
    Int_t tracks_count;
    Float_t pxs[MAX_TRACKS]; // momentum x array
    Float_t pys[MAX_TRACKS]; // momentum y array
    Float_t pzs[MAX_TRACKS]; // momentum z array
    Float_t qs[MAX_TRACKS];  // charges array

    // set addresses
    tree_in->SetBranchAddress(TRACKS_COUNT, &tracks_count);
    tree_in->SetBranchAddress(MOMENTUM_X, pxs);
    tree_in->SetBranchAddress(MOMENTUM_Y, pys);
    tree_in->SetBranchAddress(MOMENTUM_Z, pzs);
    tree_in->SetBranchAddress(CHARGE, qs);

    // get the event data
    tree_in->GetEntry(evt_no);

    // print and write data
    printf("Event no %d:\n", evt_no);
    for (Int_t track_i = 0; track_i < tracks_count; ++track_i) {
        Float_t px = pxs[track_i];
        Float_t py = pys[track_i];
        Float_t pz = pzs[track_i];
        auto mom = TVector3(px, py, pz);
        Float_t theta = mom.Theta();
        Float_t phi = mom.Phi();
        Float_t mag = mom.Mag();
        Float_t tr = mom.Perp();
        Float_t pxz1000 = 1000.0 * px * pz;
        Float_t q = qs[track_i];

        printf("|\tTrack no %3d: theta = %5.2f, phi = %5.2f, mom_abs = %7.3f, "
               "mom_tr = %7.3f\n",
               track_i, theta, phi, mag, tr);
        tree_out->Fill(px, py, pz, pxz1000, mag, tr, theta, phi, q);
    }
    printf("%d tracks total\n\n", tracks_count);
}

#define OUT_FNAME "output_example_cuts.root"
#define OUT_TNAME "ntTracks"

void task2(char const *fname, char const *tname) {
    auto tin = new TChain(tname);
    tin->Add(fname);

    auto fout = TFile::Open(OUT_FNAME, "RECREATE");
    auto tout = new TNtuple(OUT_TNAME, "Tracking block parameters",
                            "Px:Py:Pz:pxz_1000:mag:tr:theta:phi:charge");

    for (Int_t event_no = 1; event_no <= 10; ++event_no) {
        print_event(tin, event_no, tout);
    }
    tout->Write();
    fout->Close();
}
