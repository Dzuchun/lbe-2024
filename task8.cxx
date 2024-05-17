#include <RooFitResult.h>
#include <RtypesCore.h>
#include <TCanvas.h>
#include <TChain.h>
#include <TF1.h>
#include <TFitResult.h>
#include <TH1.h>
#include <TMath.h>
#include <cstdio>

Double_t fit_function(Double_t *arg, Double_t *para) {
    return para[0] * TMath::Exp(-arg[0] / para[1]) + para[2];
}

void create_histogram(char const *name, char const *ctau_expr, Double_t min_fit,
                      Double_t max_fit, Double_t min_ctau, Double_t max_ctau,
                      Int_t bin_count, TChain *chIn) {
    Float_t bin_width = (max_fit - min_fit) / bin_count;
    Int_t total_bins = bin_count * (max_ctau - min_ctau) / (max_fit - min_fit);
    TH1F *hist = new TH1F(name, name, total_bins, min_ctau, max_ctau);
    hist->GetXaxis()->SetTitle("Lifetime, cm");
    hist->GetYaxis()->SetTitle("Frequency");
    char cut[1000];
    sprintf(cut, "%s >= %f && %s < %f", ctau_expr, min_ctau, ctau_expr,
            max_ctau);
    char draw[1000];
    sprintf(draw, "%s>>%s", ctau_expr, name);
    chIn->Draw(draw, cut);

    // Fit exp to it
    TF1 *fit = new TF1("fit", fit_function, min_fit, max_fit, 3);
    fit->SetParameters((Float_t)hist->GetMaximumBin(), max_ctau / 2.0, 100.0);
    TFitResult *fit_result = hist->Fit("fit", "RQSN").Get();

    // Plot fit result
    fit->Draw("same");
    // Print relevant info
    Double_t chi2ndf = fit_result->Chi2() / fit_result->Ndf();
    const Double_t c = 30.;                    // Speed of light in cm/ns
    Double_t hl_cm = fit_result->Parameter(1); // half-life in cm
    Double_t hl_ns = hl_cm / c;                // half-life in ns
    Double_t hle_cm = fit_result->Error(1);    // half-life error in cm
    Double_t hle_ns = hle_cm / c;              // half-life error in ns
    printf("%s:\n|\tchi_2/dof = %.4f\n|\thalf-life (cm) = %.4f +- "
           "%.4f\n|\thalf-life (ns) "
           "= %.4f += %.4f\n\n",
           name, chi2ndf, hl_cm, hle_cm, hl_ns, hle_ns);
}

void task8(char const *fin, char const *tin, Double_t min_fit, Double_t max_fit,
           Double_t min_ctau, Double_t max_ctau, Int_t bin_count) {

    auto chIn = new TChain(tin);
    chIn->Add(fin);

    // Create canvas
    TCanvas *canv = new TCanvas("ctau", "");
    canv->Divide(1, 2);

    // Plot with ctau directly
    canv->cd(1);
    create_histogram("Direct ctau", "ctau", min_fit, max_fit, min_ctau,
                     max_ctau, bin_count, chIn);

    // Plot with calculated ctau
    canv->cd(2);
    create_histogram("Calculated ctau", "massK0*dlen3/pk0", min_fit, max_fit,
                     min_ctau, max_ctau, bin_count, chIn);
}
