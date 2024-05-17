#include <RtypesCore.h>
#include <TBranch.h>
#include <TChain.h>
#include <TFile.h>
#include <TNtuple.h>
#include <TVector3.h>
#include <cstdio>
#include <numeric>
#include <vector>

#define MUON_MASS 0.10565837

void invmass(char const *f1name, char const *f2name, char const *out_name,
             char const *tname, Float_t corr) {
    auto chIn = new TChain(tname);
    chIn->Add(f1name);
    chIn->Add(f2name);

    TFile fout(out_name, "RECREATE");

    Int_t Trk_ntracks;
    chIn->SetBranchAddress("Trk_ntracks", &Trk_ntracks);
    Int_t Trk_sec_vtx[250];
    chIn->SetBranchAddress("Trk_sec_vtx", Trk_sec_vtx);
    Int_t Trk_prim_vtx[250];
    chIn->SetBranchAddress("Trk_prim_vtx", Trk_prim_vtx);
    Float_t Trk_px[250];
    chIn->SetBranchAddress("Trk_px", Trk_px);
    Float_t Trk_py[250];
    chIn->SetBranchAddress("Trk_py", Trk_py);
    Float_t Trk_pz[250];
    chIn->SetBranchAddress("Trk_pz", Trk_pz);
    Float_t Trk_charge[250];
    chIn->SetBranchAddress("Trk_charge", Trk_charge);
    Int_t Trk_vtx[250];
    chIn->SetBranchAddress("Trk_vtx", Trk_vtx);
    Int_t Trk_id[250];
    chIn->SetBranchAddress("Trk_id", Trk_id);
    Float_t Trk_dedxmvd[250];
    chIn->SetBranchAddress("Trk_dedxmvd", Trk_dedxmvd);
    Int_t Trk_layinner[250];
    chIn->SetBranchAddress("Trk_layinner", Trk_layinner);
    //..........................................

    Int_t Nsecvtx;
    chIn->SetBranchAddress("Nsecvtx", &Nsecvtx);
    //..........................................
    Float_t Xvtx;
    chIn->SetBranchAddress("Xvtx", &Xvtx);
    Float_t Yvtx;
    chIn->SetBranchAddress("Yvtx", &Yvtx);
    Float_t Zvtx;
    chIn->SetBranchAddress("Zvtx", &Zvtx);
    Float_t Chivtx;
    chIn->SetBranchAddress("Chivtx", &Chivtx);
    Int_t Nmu;
    chIn->SetBranchAddress("Nmu", &Nmu);
    Int_t Muqual[50];
    chIn->SetBranchAddress("Muqual", Muqual);

    auto tout =
        new TNtuple("tout", "Psi_prim(3686.09) -> J/Psi(3096.916) pi+pi-",
                    "jpsi_mass:nmu:p1:p2:jpsi_p");

    printf("Muon mass ~~= %f GeV\n", MUON_MASS);

    Int_t events_count = chIn->GetEntries();
    printf("Events count: %d\n", events_count);

    std::vector<Float_t> masses;

    for (Int_t nEvt = 1; nEvt < events_count; nEvt++) {
        chIn->GetEntry(nEvt);

        if (Nmu < 1)
            // expected at least one muon
            continue;
        if (Trk_ntracks < 2 || Trk_ntracks > 3)
            // expected 2 or 3 tracks
            continue;

        for (Int_t aa = 0; aa < Trk_ntracks - 1; aa++) {

            if (Trk_prim_vtx[aa] < 1)
                continue;

            Float_t p1 = 0.0;
            Float_t px1 = 0.0;
            Float_t py1 = 0.0;
            Float_t pz1 = 0.0;

            px1 = corr * Trk_px[aa];
            py1 = corr * Trk_py[aa];
            pz1 = corr * Trk_pz[aa];
            p1 = sqrt(px1 * px1 + py1 * py1 + pz1 * pz1);
            if (p1 < 0.1 || p1 > 100.0)
                continue;

            TVector3 v_p1(px1, py1, pz1);
            Float_t theta1_rad = v_p1.Theta();
            Float_t theta1 = (180.0 / TMath::Pi()) * theta1_rad;
            // following line restricts polar angle
            // if(theta1<30.0||theta1>160.0) continue;

            for (Int_t bb = aa + 1; bb < Trk_ntracks; bb++) {
                if (Trk_prim_vtx[bb] < 1)
                    continue;
                if (Trk_id[bb] == Trk_id[aa])
                    continue;

                if (Trk_charge[aa] * Trk_charge[bb] >= 0)
                    // expected different change signs
                    continue;

                Float_t px2 = corr * Trk_px[bb];
                Float_t py2 = corr * Trk_py[bb];
                Float_t pz2 = corr * Trk_pz[bb];
                TVector3 v_p2(px2, py2, pz2);
                Float_t p2 = v_p2.Mag();

                if (p2 < 0.1 || p2 > 100.0)
                    // expect second momentum in range [0.1, 100]
                    continue;

                Float_t theta2_rad = v_p2.Theta();
                Float_t theta2 = (180.0 / TMath::Pi()) * theta2_rad;
                // following line restricts polar angle
                // if(theta2 < 30.0 || theta2 > 160.0) continue;

                Float_t E1_pi = TMath::Sqrt(p1 * p1 + MUON_MASS * MUON_MASS);
                Float_t E2_pi = TMath::Sqrt(p2 * p2 + MUON_MASS * MUON_MASS);
                Float_t mass_jpsi =
                    TMath::Sqrt(2. * (MUON_MASS * MUON_MASS + E1_pi * E2_pi -
                                      px1 * px2 - py1 * py2 - pz1 * pz2));

                if (mass_jpsi < 2.8 || mass_jpsi > 3.5)
                    // expect JPsi mass be in range [2.8, 3.5]
                    continue;

                TVector3 v_P_jpsi(px1 + px2, py1 + py2, pz1 + pz2);
                Float_t P_jpsi = v_P_jpsi.Mag();

                if (P_jpsi < 0.1 || P_jpsi > 100.0)
                    // expected momentum in range [0.1, 100]
                    continue;

                masses.push_back(mass_jpsi);

                tout->Fill(mass_jpsi, Nmu, p1, p2, P_jpsi);
                printf("event_no %3d: ntracks = %2d, mass = %1.3f, Nmu = %2d\n",
                       nEvt, Trk_ntracks, mass_jpsi, Nmu);
            }
        }
    }
    Float_t average_mass =
        std::accumulate(masses.begin(), masses.end(), 0.0) / masses.size();
    printf("Total jpsi candidates: %ld\nAverage mass: %1.4f\n", masses.size(),
           average_mass);
    tout->Write();
    fout.Close();
}
