#include <RtypesCore.h>
#include <TCanvas.h>
#include <TChain.h>
#include <TH2F.h>
#include <TROOT.h>
#include <TVirtualPad.h>

void beams(Float_t max_Zvtx, Float_t min_Zvtx = 0) {
    gROOT->Reset();
    gROOT->SetStyle("Plain");

    // open a file
    TChain *tin = new TChain("orange");
    tin->Add("data_06p_60005_60010_01.root");

    // create a canvas
    TCanvas *canv = new TCanvas("au1", "ZEUS" - 1);
    canv->Divide(1, 3);

    // switch to first element
    canv->cd(1);
    char condition[250];
    sprintf(condition, "Zvtx!=0 && abs(Zvtx)>=%f && abs(Zvtx)<=%f", min_Zvtx,
            max_Zvtx);
    tin->Draw("Yvtx:Xvtx>>h_2vertex", condition);
    // tin->Draw("Yvtx:Xvtx>>h_2vertex", condition, "CONT1");
    auto h_2vertex = (TH2F *)gPad->GetPrimitive("h_2vertex");
    h_2vertex->GetXaxis()->SetTitle("X, mcm");
    h_2vertex->GetXaxis()->SetLimits(1.66, 1.74); // manually chosen
    h_2vertex->GetYaxis()->SetTitle("Y, mcm");
    h_2vertex->GetYaxis()->SetLimits(0.242, 0.275); // manually chosen
    h_2vertex->SetTitle("XY primary vertex position");

    // switch to second element
    canv->cd(2);
    tin->Draw("Bspt_y:Bspt_x>>h_2");
    auto h_2 = (TH2F *)gPad->GetPrimitive("h_2");
    h_2->GetXaxis()->SetTitle("X /cm");
    h_2->GetYaxis()->SetTitle("Y /cm");
    h_2->SetTitle("Beam Spot");

    // switch third element
    canv->cd(3);
    // tin->Draw("Zvtx>>h_z");
    tin->Draw("Zvtx>>h_z", "Zvtx!=0");
    auto h_z = (TH2F *)gPad->GetPrimitive("h_z");
    h_z->GetXaxis()->SetTitle("Z /cm");
    h_z->GetYaxis()->SetTitle("");
    h_z->SetTitle("Z primary vertex position");
}
