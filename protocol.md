---
header-line1: Київський Національний Університет імені Тараса Шевченка
header-line2: Фізичний факультет
document-type: ЗВІТ
title-line1: про Виконання лабораторних робіт
title-line2: З КУРСУ НИЗЬКОФОНОВІ ЕКСПЕРИМЕНТИ
title-line3: (3й курс)
author-line1: виконував
author-line2: Дяченко Артем
author-line3: студент 3го курсу, ФВЕ
date: травень 2024
prof: PROF_UNIQUE_VARIABLE
code-section-title: Деякі вихідні коди
---

# Робота 1

## Вправа 00

За допомогою наступного макро, дізнаємось склад наданого файлу:
```cpp
#include <TFile.h>

void task1_tname(char const *fname) {
    auto fin = TFile::Open(fname);
    fin->ls();
}
```

Отримано такий вивід:
```
TFile**         data_06e_58207_58211_01.root    orange
 TFile*         data_06e_58207_58211_01.root    orange
  KEY: TTree    orange;6        orange tree [current cycle]
  KEY: TTree    orange;5        orange tree [backup cycle]
```

Тож у файлі міститься дві версії дерева із назвою `orange`.

Для більш детального дослідження, було написано такий макро:
```cpp
#include <TFile.h>
#include <TTree.h>
#include <cstdio>
#include <unordered_set>

void task1_00(char const *input_file, char const *tree_name) {
    std::unique_ptr<TFile> treeFile(TFile::Open(input_file));
    auto tree = treeFile->Get<TTree>(tree_name);

    int runnr;
    tree->SetBranchAddress("Runnr", &runnr);

    printf("Leaves count: %d\n", tree->GetListOfLeaves()->GetSize());

    std::unordered_set<int> run_ids{};

    // src: https://root.cern/manual/trees/
    int entry;
    for (entry = 0; tree->LoadTree(entry) >= 0; ++entry) {
        // Load the data for the given tree entry
        tree->GetEntry(entry);
        run_ids.insert(runnr);
    }

    printf("Total entries: %d\n", entry);
    printf("Unique run ids: ");
    for (const auto &id : run_ids) {
        printf("%d ", id);
    }
    printf("\nRun ids count: %ld", run_ids.size());
}
```

В результаті його виконання, маємо:
```
Leaves count: 778
Total entries: 46642
Unique run ids: 58211 58210 58208 58207 
Run ids count: 4
```

Таким чином, отримано кількість листків, кількість записів, кількість та номери унікальних ранів.

## Вправа 01

В результаті запуску yаданого макро, отримано:
```
Event number= 1  Number of tracks per event  3
Event number= 2  Number of tracks per event  36
Event number= 3  Number of tracks per event  43
Event number= 4  Number of tracks per event  82
Event number= 5  Number of tracks per event  52
Event number= 6  Number of tracks per event  44
Event number= 7  Number of tracks per event  27
Event number= 8  Number of tracks per event  30
Event number= 9  Number of tracks per event  14
```

**Чи всі події перебирались у цій програмі?** Ні, лише перші 10

**Скільки всього було треків у виведених на екран подіях?** Згадується 331 трек

## Вправа 02

В результаті запуску наданого макро, маємо:
```
 Event number= 0  Number of tracks per event  0

 Event number= 1  Number of tracks per event  3
Trk_px= 0.115324   Trk_py= 0.0890118   Trk_pz= 0.0975036
Trk_px= 0.0425097   Trk_py= -0.0197481   Trk_pz= -0.151317
Trk_px= 0.0506653   Trk_py= -0.180304   Trk_pz= 0.909142

 Event number= 2  Number of tracks per event  36
Trk_px= -0.419252   Trk_py= -1.73292   Trk_pz= 1.08233
Trk_px= -0.275612   Trk_py= -0.930108   Trk_pz= 0.0177232
Trk_px= -0.0481743   Trk_py= 0.181739   Trk_pz= 0.118522

 Event number= 3  Number of tracks per event  43
Trk_px= -0.019022   Trk_py= -0.529097   Trk_pz= 0.486201
Trk_px= -0.498298   Trk_py= 0.363928   Trk_pz= 0.259796
Trk_px= 0.5797   Trk_py= 0.0139583   Trk_pz= -0.339683

 Event number= 4  Number of tracks per event  82
Trk_px= 0.0628539   Trk_py= 0.290261   Trk_pz= -0.326959
Trk_px= 0.114369   Trk_py= 0.205348   Trk_pz= -0.154525
Trk_px= 0.148934   Trk_py= 0.130263   Trk_pz= 0.270453

 Event number= 5  Number of tracks per event  52
Trk_px= 0.150263   Trk_py= -0.0622271   Trk_pz= 0.107734
Trk_px= -0.247925   Trk_py= -0.111175   Trk_pz= 0.0989094
Trk_px= -0.632184   Trk_py= -0.0933311   Trk_pz= 0.169439

 Event number= 6  Number of tracks per event  44
Trk_px= 0.603789   Trk_py= 0.198145   Trk_pz= -0.427846
Trk_px= 0.273863   Trk_py= -0.462179   Trk_pz= -0.10767
Trk_px= -0.451562   Trk_py= 0.183692   Trk_pz= 0.155203

 Event number= 7  Number of tracks per event  27
Trk_px= 0.0968536   Trk_py= 0.308761   Trk_pz= 0.310661
Trk_px= 0.0663098   Trk_py= -0.347322   Trk_pz= 0.620436
Trk_px= 0.44233   Trk_py= 0.100652   Trk_pz= 1.00148

 Event number= 8  Number of tracks per event  30
Trk_px= -0.216995   Trk_py= 0.193151   Trk_pz= -0.0788407
Trk_px= 1.46775   Trk_py= -0.549828   Trk_pz= -1.55404
Trk_px= 0.350906   Trk_py= -0.633372   Trk_pz= 0.580004

 Event number= 9  Number of tracks per event  14
Trk_px= 0.392482   Trk_py= 0.122105   Trk_pz= -0.081405
Trk_px= -0.104405   Trk_py= -0.204188   Trk_pz= -0.0456669
Trk_px= -0.201977   Trk_py= -0.648358   Trk_pz= -0.73981
```

Для виведення додаткових даних, було написано окремий макро:
```cpp
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
```

В результаті його виконання, маємо:
```
Event no 1:
|       Track no  0: momentum = [  0.115,   0.089,   0.098], charge =       1.00e
|       Track no  1: momentum = [  0.043,  -0.020,  -0.151], charge =       1.00e
|       Track no  2: momentum = [  0.051,  -0.180,   0.909], charge =       1.00e
3 tracks total, charge signs: 3/0

Event no 2:
|       Track no  0: momentum = [ -0.419,  -1.733,   1.082], charge =       1.00e
|       Track no  1: momentum = [ -0.276,  -0.930,   0.018], charge =       1.00e
|       Track no  2: momentum = [ -0.048,   0.182,   0.119], charge =       1.00e
|       Track no  3: momentum = [ -0.221,  -0.558,  -0.511], charge =       1.00e
|       Track no  4: momentum = [  0.124,  -0.257,   0.198], charge =      -1.00e
|       Track no  5: momentum = [  0.574,  -0.359,   0.173], charge =      -1.00e
|       Track no  6: momentum = [  0.127,  -0.455,   0.766], charge =      -1.00e
|       Track no  7: momentum = [  0.695,  -0.305,   1.394], charge =      -1.00e
|       Track no  8: momentum = [  0.098,  -0.089,  -0.114], charge =      -1.00e
|       Track no  9: momentum = [  0.261,   0.389,   0.536], charge =      -1.00e
|       Track no 10: momentum = [ -0.179,   0.472,   1.630], charge =       1.00e
|       Track no 11: momentum = [  0.311,   0.551,   2.856], charge =      -1.00e
|       Track no 12: momentum = [  0.271,   0.028,   1.187], charge =       1.00e
|       Track no 13: momentum = [ -0.632,  -0.042,   0.168], charge =      -1.00e
|       Track no 14: momentum = [  0.045,  -0.120,  -0.106], charge =       1.00e
|       Track no 15: momentum = [ -0.170,   0.088,   0.174], charge =      -1.00e
|       Track no 16: momentum = [  0.053,   0.048,  -0.035], charge =       1.00e
|       Track no 17: momentum = [  0.076,   0.040,  -0.156], charge =       1.00e
|       Track no 18: momentum = [ -0.070,  -0.091,   0.037], charge =      -1.00e
|       Track no 19: momentum = [ -0.061,  -0.060,  -0.312], charge =      -1.00e
|       Track no 20: momentum = [  0.093,   0.168,   0.041], charge =       1.00e
|       Track no 21: momentum = [ -0.157,   0.070,   0.557], charge =      -1.00e
|       Track no 22: momentum = [  0.057,  -0.125,  -0.060], charge =       1.00e
|       Track no 23: momentum = [  0.238,   0.262,   1.269], charge =       1.00e
|       Track no 24: momentum = [ -0.049,  -0.384,  -2.607], charge =      -1.00e
|       Track no 25: momentum = [ -0.236,  -0.116,  -0.734], charge =       1.00e
|       Track no 26: momentum = [  0.046,   0.013,   0.504], charge =      -1.00e
|       Track no 27: momentum = [  0.002,  -0.036,  -0.364], charge =      -1.00e
|       Track no 28: momentum = [  0.010,  -0.165,   0.735], charge =      -1.00e
|       Track no 29: momentum = [ -0.402,   0.297,   7.280], charge =      -1.00e
|       Track no 30: momentum = [ -0.018,   0.042,  -0.765], charge =       1.00e
|       Track no 31: momentum = [  0.224,   0.237,   0.425], charge =      -1.00e
|       Track no 32: momentum = [  0.261,   0.185,  -1.340], charge =      -1.00e
|       Track no 33: momentum = [ -0.117,  -0.112,   0.868], charge =      -1.00e
|       Track no 34: momentum = [  0.638,  -0.362,   4.479], charge =       1.00e
|       Track no 35: momentum = [  0.727,   0.091,   5.454], charge =       1.00e
36 tracks total, charge signs: 16/20
```

## Вправа 03

Дерево-результат називається `ntTracks`, задається у стрічці 38 наданого макро.

Виконавши макро, та відкривши `output_example.root` у `TBrowser`, бачимо розподіли для компонент треків (графіки [@fig:Px]-[@fig:charge1]). Розподіли компонент за формою нагадують нормальні, а розподіл заряду є дискретним із двома присутніми значеннями: `+1` і `-1`.

З графіка [@fig:charge1] видно, що більше було треків із додатнім зарядом.


![[Pasted image 20240517135346.png]]
{ref=Px, caption="."}
![[Pasted image 20240517135405.png]]
{ref=Py, caption="."}
![[Pasted image 20240517135424.png]]
{ref=Pz, caption="."}
![[Pasted image 20240517135826.png]]
{ref=charge1, caption="."}

------

## Вправа 04

*Примітка:* *оригінальний код містить* **UB** *через записування у неаллоковану пам'ять. Було змінено розмір масиву `tr` з 4 на 5.*

В результаті запуску наданого макро, маємо:
```

 Event number= 1  Number of tracks per event  3

 Event number= 2  Number of tracks per event  36

 Event number= 3  Number of tracks per event  43

 Event number= 4  Number of tracks per event  82

 Event number= 5  Number of tracks per event  52

 Event number= 6  Number of tracks per event  44

 Event number= 7  Number of tracks per event  27

 Event number= 8  Number of tracks per event  30

 Event number= 9  Number of tracks per event  14

```

Після розкоментовування, маємо:
```

 Event number= 1  Number of tracks per event  3

 Event number= 2  Number of tracks per event  36

 Event number= 3  Number of tracks per event  43

 Event number= 6  Number of tracks per event  44

 Event number= 7  Number of tracks per event  27

 Event number= 8  Number of tracks per event  30

 Event number= 9  Number of tracks per event  14
 
```

Після додавання умови, не виведено подій із кількістю треків більше 50.

Розглянувши вхідний файл `output_example_cuts.root` у `TBrowser`, бачимо що всі компоненти треку та заряди є додатними.

------
# Робота 2

Результатом виконання наданого макро, є
```
 Event number= 1  Number of tracks per event  3
track 1)  theta= 0.980975    phi=0.657332
track 2)  theta= 2.8412    phi=-0.434892
track 3)  theta= 0.203162    phi=-1.29686

 Event number= 2  Number of tracks per event  36
track 1)  theta= 1.02521    phi=-1.80817
track 2)  theta= 1.55253    phi=-1.85888
(... ще 340 рядків)
```

Тут зазначаються лише сферичні кути треку.

Для виведення та запису більшої кількості інформації про кожен трек, було написано наступний макро:
```cpp
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
```

В результаті, отримано
```
Event no 1:
|       Track no   0: theta =  0.98, phi =  0.66, mom_abs =   0.175, mom_tr =   0.146
|       Track no   1: theta =  2.84, phi = -0.43, mom_abs =   0.158, mom_tr =   0.047
|       Track no   2: theta =  0.20, phi = -1.30, mom_abs =   0.928, mom_tr =   0.187
3 tracks total

(... ще 380 рядків)
```

За допомогою `TBrowser` також було перевірено, що тепер дерево справді містить нові листки:

![[Pasted image 20240517144337.png]]
{width=0.2}
![[Pasted image 20240517144356.png]]
{ref=mom_tr, caption="Розподіл поперечної компоненти імпульсу"}
![[Pasted image 20240517144436.png]]
{ref=mom_abs, caption="Розподіл модуля імпульсу"}

------

# Робота 3

*Примітка: файл `data_06e_59933_59933_01.root` не було надано, тож замість нього використовувався `data_06p_60005_60010_01.root`.*

**Яку форму має двовимірний профіль місця перетину двох пучків?** Математично – досить складну. Але на вигляд вона може бути схожою на коло або щось на кшталт еліпса.

Наданий макро не виводить очікуваних графіків, через невідповідні межі гістограм. Для відображення аналогічних даних, було написано наступний макро:
```cpp
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

    // print info
    printf("Leaves count: %d\nEntries: %lld\n",
           tin->GetListOfLeaves()->GetSize(), tin->GetEntries());

    // create a canvas
    TCanvas *canv = new TCanvas("au1", "ZEUS" - 1);
    canv->Divide(1, 3);

    // create histogram
    auto h_2vertex = new TH2F("h_2vertex", "Primary vertex (x, y)", 100, 1.66,
                              1.74, 100, 0.242, 0.275); // manually chosen
    canv->cd(1);
    char condition[250];
    sprintf(condition, "Zvtx!=0 && abs(Zvtx)>=%f && abs(Zvtx)<=%f", min_Zvtx,
            max_Zvtx);
    // tin->Draw("Yvtx:Xvtx>>h_2vertex", condition);
    tin->Draw("Yvtx:Xvtx>>h_2vertex", condition, "CONTZ");
    h_2vertex->GetXaxis()->SetTitle("X, mcm");
    h_2vertex->GetYaxis()->SetTitle("Y, mcm");
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
```


Результат виконання наведено на графіку [@fig:beams_spot]. Текстова частина виявилась наступною:
```
Leaves count: 1137
Entries: 5719
```

Тобто на нижньому графіку було відсіяно близько двох тисяч записів, у яких $Zvtx\equiv0$ (стрічка 49 вихідного коду).

![[Pasted image 20240517152542.png]]
{ref=beams_spot, caption="Результат виконання макро для $\lvert Zvtx \rvert \in [0; 99999]$"}

У створеному макро передбачено обмеження допустимого діапазону $Zvtx$. Наприклад, для $\lvert Zvtx \rvert \leq 30$, отримується графік [@fig:beams30], для $\lvert Zvtx \rvert \leq 20$ – графік [@fig:beams20], для $\lvert Zvtx \rvert \geq 20$ – графік [@fig:beams20inv]

![[Pasted image 20240517152204.png]]
{ref=beams30, caption="Результат виконання макро для $\lvert Zvtx \rvert \in [0; 30]$"}

![[Pasted image 20240517152428.png]]
{ref=beams20, caption="Результат виконання макро для $\lvert Zvtx \rvert \in [0; 20]$"}

![[Pasted image 20240517152458.png]]
{ref=beams20inv, caption="Результат виконання макро для $\lvert Zvtx \rvert \in [20; 99999]$"}

Приблизний розмір області – $300\mu m\times30\mu m$.

----

# Робота 4

*Примітка: файл `data_06e_59933_59933_01.root` не було надано, тож замість нього використовувався `data_06p_60005_60010_01.root`.*

*Примітка: наданий макро містить повторні означення. Їх було закоментовано.*

*Примітка: наданий макро невірно визначає тип гілки `Muqual` як `Float_t`, коли `root` очікує `Int_t`.* 

Маса, енергія та імпульс пов'язані наступним чином:
$$
m^{2} = E^{2} - p^{2}\qquad (c=1)
$$

## Вправа 0

**Яка маса мюона у МеВ?** – близько 105 МеВ.

## Вправа 1

Вихідний файл називається `jpsi_out.root`, що задається на рядку 19. Рядок 73 містить список листків вихідного файлу: `jpsi_mass`, `nmu`, `p1`, `p2`, `jpsi_p`.

## Вправа 2

Для підв'язки двох файлів у `TChain` можна підв'язати їх по черзі:
```cpp
chain->Add("file1.root");
chain->Add("file2.root");
```

Або ж скористатись `shell-expand`:
```cpp
chain->Add("*.root");
```

Це підв'яже всі `root`-файли з поточної теки. Я не використовуватиму цей синтаксис, адже маю у поточній теці багато сторонніх `root`-файлів.

Після виконання наданого макро, маємо такий вивід:
```
evt_No= 3414  mass_jpsi= 2.98917  Trk_ntracks= 3
```

Для об'єднання даних з обох наданих файлів, та подальшого аналізу було написано наступний макро:
```cpp
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

                Int_t prodCh = 0;
                prodCh = Trk_charge[aa] * Trk_charge[bb];
                if (prodCh >= 0)
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
```

Тут код переписано майже без змін: його лише було відформатовано та підписано фізичні змісти всіх наявних катів.

Після його виконання із $corr=1.0$, маємо:
```
Events count: 52361
event_no 3414: ntracks =  3, mass = 2.989, Nmu =  2
event_no 6955: ntracks =  2, mass = 3.070, Nmu =  2
event_no 11920: ntracks =  2, mass = 3.090, Nmu =  2
event_no 14320: ntracks =  2, mass = 3.114, Nmu =  2
event_no 25687: ntracks =  2, mass = 2.975, Nmu =  2
event_no 27709: ntracks =  2, mass = 3.096, Nmu =  1
event_no 32218: ntracks =  2, mass = 3.383, Nmu =  3
event_no 33206: ntracks =  2, mass = 2.990, Nmu =  1
event_no 36404: ntracks =  3, mass = 3.130, Nmu =  1
event_no 38206: ntracks =  2, mass = 3.124, Nmu =  2
event_no 46671: ntracks =  2, mass = 3.072, Nmu =  1
event_no 49075: ntracks =  2, mass = 3.040, Nmu =  3
Total jpsi candidates: 12
Average mass: 3.0895
```

## Вправа 3

Результат для $corr=1.5$:
```
event_no 1536: ntracks =  2, mass = 3.188, Nmu =  1
event_no 2626: ntracks =  2, mass = 3.232, Nmu =  2
event_no 2659: ntracks =  2, mass = 3.434, Nmu =  1
event_no 3367: ntracks =  3, mass = 3.289, Nmu =  6
event_no 5598: ntracks =  3, mass = 3.213, Nmu =  1
event_no 22546: ntracks =  2, mass = 3.012, Nmu =  3
event_no 23662: ntracks =  2, mass = 2.986, Nmu =  1
event_no 25959: ntracks =  3, mass = 2.814, Nmu =  1
event_no 26772: ntracks =  2, mass = 3.183, Nmu =  1
event_no 29647: ntracks =  3, mass = 2.992, Nmu =  5
event_no 31765: ntracks =  3, mass = 2.850, Nmu =  2
event_no 34858: ntracks =  2, mass = 3.014, Nmu =  3
event_no 35115: ntracks =  3, mass = 3.370, Nmu =  2
event_no 41688: ntracks =  2, mass = 3.311, Nmu =  1
event_no 44390: ntracks =  3, mass = 3.413, Nmu =  1
Total jpsi candidates: 15
Average mass: 3.1534
```

Результат для $corr=0.5$:
```
event_no 492: ntracks =  2, mass = 3.124, Nmu =  2
event_no 1575: ntracks =  2, mass = 3.360, Nmu =  2
event_no 2177: ntracks =  2, mass = 2.891, Nmu =  2
event_no 2411: ntracks =  2, mass = 3.014, Nmu =  2
event_no 10608: ntracks =  2, mass = 3.484, Nmu =  2
event_no 18243: ntracks =  2, mass = 2.891, Nmu =  2
event_no 28625: ntracks =  2, mass = 3.259, Nmu =  2
event_no 30891: ntracks =  2, mass = 2.820, Nmu =  1
event_no 33052: ntracks =  2, mass = 2.923, Nmu =  2
event_no 33513: ntracks =  2, mass = 3.288, Nmu =  1
Total jpsi candidates: 10
Average mass: 3.1054
```

Видно, що внаслідок зміни $corr$, середня маса кандидатів $J/\Psi$ змінюється в межах $2\%$.

## Вправа 4

Події у яких є гарантовано два мюони є підмножиною подій, у яких є хоча б один мюон, тож за умови $Nmu == 2$ кількість кандидатів зменшиться.

Важко передбачити, як зміниться кількість кандидатів, якщо розглядатимуться лише події без жодного мюона.

## Вправа 5

Умова
```cpp
if (Trk_ntracks < 2 || Trk_ntracks > 3) continue;
```

залишає виконання лише подіям, що мають 2 або 3 треки.

## Вправа 6

Умова
```cpp
if (Trk_charge[aa] * Trk_charge[bb] >= 0) continue;
```

залишає виконання лише парам треків, заряди яких мають різні знаки

## Вправа 7

Змінні `aa` та `bb` позначають індекси ітерування.

Для розрахунку інваріантної маси $J/\Psi$, застосовується наступний код:
```cpp
Float_t mass_jpsi = TMath::Sqrt(2. * (MUON_MASS * MUON_MASS + E1_pi * E2_pi -
	px1 * px2 - py1 * py2 - pz1 * pz2));
```

Що математично відповідає
$$
m_{J/\Psi} = \sqrt{ 2 (m_{\mu}^{2} + (P_{1}^{\mu}\cdot P_{2}^{\mu})) }
$$
де $P^{\mu}$ – 4-імпульси.

На величини імпульсів треків дочірніх частинок накладено обмеження $\lvert \vec{p}_{1,2} \rvert \in [0.1, 100.0]$.

Табличне значення: $m_{J/\Psi} \approx 3.096$ ГеВ. $J/\Psi$ приблизно втричі важча за протон.

У зазначеному макро використовувалось вікно пошуку $m_{J/\Psi} \in [2.8, 3.5]$ ГеВ.

За допомогою `TBrowser`, було спостережено отриманий розподіл $m_{J/\Psi}$ (графік [@fig:mjpsi]). Очевидно, що кількість даних є замалою для формування піку. Після ребіновки (графік [@fig:mjpsi_rebin]), формується якийсь натяк на пік у районі $3.1$ ГеВ, але якихось висновків на цим все ще зробити не можна.

![[Pasted image 20240517162124.png]]
{ref=mjpsi, caption="."}

![[Pasted image 20240517162643.png]]
{ref=mjpsi_rebin, caption="."}

------
# Робота 5

Каони розпадаються різний час залежно від кута змішування:
$$
K_{L} = K_{0} + \bar{K}_{0} \qquad K_{S} = K_{0} - \bar{K}_{0}
$$

## Вправа 1

*Примітка: файлів `k0_ctau_{0,2-5}.cxx` надано не було.*

У наданому файлі присутні багато параметрів. Дерево називається `ntK0`.

У файлі наведено 70011 подій. Кожна із подій представляє з себе реконструйований акт розпаду $K_{0}$.

## Вправа 2-3

Для виведення маси $K_{0}$, було написано наступний макро:
```cpp
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
```

В результаті виконання, відображається гістограма на графіку [@fig:k0_mass]. Присутній досить суттєвий фон та нестабільний сигнал.

![[Pasted image 20240517172005.png]]
{ref=k0_mass, caption="."}

## Вправа 4

Для наданого файлу було додано код для обчислення площі фону та частки пік-фон. В результаті було отримано графік [@fig:k0_mass_approx] та наступний вивід:
```
Peak sum: 20685.58
Bg sum: 19038.32
Signal/Bg ratio: 1.087
```

![[Pasted image 20240517172443.png]]
{ref=k0_mass_approx, caption="."}

## Вправа 5

Описане попередження про втікання пам'яті з'являється лише за повторного запуску макро і пов'язане із відсутністю автоматизованого менеджменту пам'яті, або використання для цього GC.

Мануальна чистка пам'яті на рядках 13-16 дійсно прибирає згадане попередження, але це наразі не актуально, адже я запускаю `root` заново для кожного макро.

------

# Робота 6

*Примітка: файл `data_06e_59933_59933_01.root` не було надано, тож замість нього використовувався `data_06e_58207_58211_01.root`.*

## Вправа 0

Файл `select_DIS_00.cxx` нічого не виконує, і містить 546 NULL-символів.

## Вправа 1

Файл `select_DIS_01.cxx` накладає обмеження на параметр `Sincand`. Внаслідок цього із початкової тисячі подій залишається 374, тобто цей кат відкинув близько 600 подій.

## Вправа 2

Енергія електрона до розсіяння – більше за 10 ГеВ. 337 події мають енергію електрона після розсіяння більше ніж 10 ГеВ.

## Вправа 3

Третім катом виступає обмеження $Siq2el \in [10.0, 350.0]$. Після цього залишаються 172 події.

------

# Робота 7

1. Масив кутів та їх похибок заповнюється на стрічках 77-78
2. Масив кількостей $K_{0}$ та їх похибок заповнюється на стрічках 63-64
3. Вивід кількостей та їх похибок робиться на стрічці 68. Її було замінено на `printf("\\tsum[%d] = %3.3f +- %3.3f\\n", kk, sum[kk], e_sum[kk]);`.
4. Новий аркуш вводиться на стрічці 72
5. Для `TGraphErrors` використовується звичайний конструктор `TGraphErrors(Int_t n, const Float_t *x, const Float_t *y, const Float_t *ex = nullptr, const Float_t *ey = nullptr)`.
6. До наданого макро було застосовано наступний патч для зміни синтаксису у кінці:
```
81,87c81,88
< gr_theta->SetTitle("");
< //gr_theta->SetFillColor(40);
< gr_theta->Draw("ALP");
< 
< 
< 
< 
---
> gr_theta->GetXaxis()->SetTitle("Polar angle, degree");
> gr_theta->GetYaxis()->SetTitle("Events count");
> gr_theta->SetTitle("Theta");
> gr_theta->SetMarkerColor(2);
> gr_theta->SetLineColor(4);
> gr_theta->SetMarkerSize(0.8);
> gr_theta->SetMarkerStyle(20);
> gr_theta->Draw("AP[]");
```

В результаті, було отримано графік [@fig:TGE].

![[Pasted image 20240517181150.png]]
{ref=TGE, caption="."}

------

# Робота 8

На графіку [@fig:ctau_dist] зображено розподіл `ctau`. Видно, що він не є чисто експоненційним:
- малі часи розпаду практично не реєструвались, що не відповідає експоненційному закону
- "хвіст" розподілу неочікувано обривається за часу порядку 18 см

![[Pasted image 20240517181741.png]]
{ref=ctau_dist, caption = "."}

Точну причина цих артефактів передбачити важко, адже вони можуть бути викликані як геометрією детектора, так і штучними катами або перетвореннями, що провели над файлом.

У зв'язку із цим, апроксимація проводилась функцією виду
$$
n(x) = p_{0} \cdot e^{ - x/p_{1} } + p_{2}
$$

Та на проміжку, що виключає артефакт на початку (десь за $x\geq 1.0$).

В результаті було зроблено макро
```cpp
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
    Double_t chi2 = fit_result->Chi2();
    Int_t dof = fit_result->Ndf();
    Double_t chi2dof = chi2 / dof;
    const Double_t c = 30.;                    // Speed of light in cm/ns
    Double_t hl_cm = fit_result->Parameter(1); // half-life in cm
    Double_t hl_ns = hl_cm / c;                // half-life in ns
    Double_t hle_cm = fit_result->Error(1);    // half-life error in cm
    Double_t hle_ns = hle_cm / c;              // half-life error in ns
    printf("%s:\n|\tchi2 = %.2f\n|\tdof = %d\n|\tchi2/dof = %.4f\n|\thalf-life "
           "(cm) = %.4f +- %.4f\n|\thalf-life (ns) = %.4f += %.4f\n\n",
           name, chi2, dof, chi2dof, hl_cm, hle_cm, hl_ns, hle_ns);
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
```

Для `min_fit=1.0`, `max_fit=18.0`, `min_ctau=0.0`, `max_ctau=20.0`, `bin_count=100`, маємо

```
Direct ctau:
|       chi2 = 135.25
|       dof = 96
|       chi2/dof = 1.4089
|       half-life (cm) = 3.0407 +- 0.0248
|       half-life (ns) = 0.1014 += 0.0008

Calculated ctau:
|       chi2 = 135.25
|       dof = 96
|       chi2/dof = 1.4089
|       half-life (cm) = 3.0407 +- 0.0248
|       half-life (ns) = 0.1014 += 0.0008
```

а також графік [@fig:ctau_fit]

![[Pasted image 20240517193331.png]]
{ref=ctau_fit, caption="."}

Було проведено дві апроксимації:
- для наведеного у файлі `ctau`
- для розрахованого `ctau` за формулою `massK0*dlen3/pk0`

Результати виявились однаковими, що означає правильність запропонованої формули для `ctau`.

В результаті апроксимацій отримано $\tilde{\chi}^{2} \approx 1.4$, що відповідає ймовірності $0.5\%$ (?)