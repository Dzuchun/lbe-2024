UNTRACKED_FNAMES = $(TASKS_FNAME) $(ROOT_E_FNAME) $(LOOP_01_FNAME) $(LOOP_02_FNAME) $(LOOP_03_FNAME) output_example.root $(LOOP_04_FNAME) $(LOOP_04_FNAME_MODIFIED) output_example_cuts.root $(LOOP_05_FNAME) $(BEAMS_FNAME) $(ROOT_P_FNAME) $(MASS_FNAME) $(INVMASS_FOUT) $(ROOT_K0_FNAME) $(K0_FNAME) $(DIS0_FNAME) $(DIS1_FNAME) $(DIS2_FNAME) $(DIS3_FNAME) $(TGE_FNAME) $(PROTOCOL_FNAME) ./protocol_tmp.md ./images/** images/ ./.kyomato_tmp/** .kyomato_tmp

.PHONY: clean
clean:
	-rm $(UNTRACKED_FNAMES)

.PHONY: gitignore
gitignore:
	-rm .$@
	touch .$@
	for fname in $(UNTRACKED_FNAMES); do \
		echo $$fname >> .$@; \
    done

.PHONY: browser
browser:
	root -t -l -x -e 'new TBrowser'

TASKS_FNAME := tasks.pdf
TASKS_ID := 1Na83v679SGG0BeOCS22yW2SRjxna2xA8
TASKS_URL := "https://drive.usercontent.google.com/download?id=$(TASKS_ID)&export=download"
tasks.pdf:
	wget --output-document=./$(TASKS_FNAME) $(TASKS_URL)

ROOT_E_FNAME := data_06e_58207_58211_01.root
ROOT_E_ID := 1-jxowx7Cn8gjbBK4lGQwyiXMJRZx_c96
ROOT_E_URL := "https://drive.usercontent.google.com/download?id=$(ROOT_E_ID)&confirm=t"

$(ROOT_E_FNAME):
	wget --output-document=./$(ROOT_E_FNAME) $(ROOT_E_URL)

ROOT_E_TNAME := orange

task1: task1-00 task1-01 task1-02 task1-03 task1-04
	echo "$@ done"

task1-00: task1-00a task1-03b task1-00c task1-00d
	@echo "$@ done"

task1-00a: $(ROOT_E_FNAME)
	root -t -q -l -x 'task1_tname.cxx("$(ROOT_E_FNAME)")'
	@echo "Tree name: ${ROOT_E_TNAME}(?)"

task1-00b: task1-00-sc

task1-00c: task1-00-sc

task1-00d: task1-00-sc
	
task1-00-sc: $(ROOT_E_FNAME)
	root -t -q -l -x 'task1_00.cxx("${ROOT_E_FNAME}", "${ROOT_E_TNAME}")'

LOOP_01_FNAME := loop_01.cxx
LOOP_01_ID := 1vShHEqolelhXekvUmy8o_p0KypNkEdJz
LOOP_01_URL := "https://drive.usercontent.google.com/download?id=$(LOOP_01_ID)&confirm=t"

$(LOOP_01_FNAME):
	wget --output-document=./$(LOOP_01_FNAME) $(LOOP_01_URL)

task1-01: task1-01-lp task1-01a task1-01b
	@echo "$@ done"

task1-01-lp: $(LOOP_01_FNAME) $(ROOT_E_FNAME)
	root -t -q -l -x $(LOOP_01_FNAME)

task1-01a:
	@echo "$@: loop1 iterates through 10 first events"

task1-01b:
	# track numbers were 3 36 43 82 52 44 27 30 14
	@echo "$@: loop1 mentions 331 tracks total"

LOOP_02_FNAME := loop_02.cxx
LOOP_02_ID := 1H2Wo6wM02ax3eSaUGbl4DwOYW-P2dvej
LOOP_02_URL := "https://drive.usercontent.google.com/download?id=$(LOOP_02_ID)&confirm=t"

$(LOOP_02_FNAME):
	wget --output-document=./$(LOOP_02_FNAME) $(LOOP_02_URL)

task1-02: task1-02-lp task1-02a task1-02b task1-02c
	@echo "$@ done"

task1-02-lp: $(LOOP_02_FNAME) $(ROOT_E_FNAME)
	root -t -q -l -x $(LOOP_02_FNAME)

task1-02a: task1-02-sc

task1-02b: task1-02-sc

task1-02c: task1-02-sc

task1-02-sc: task1_02.cxx
	root -t -q -l -x 'task1_02.cxx("${ROOT_E_FNAME}", "${ROOT_E_TNAME}")'

LOOP_03_FNAME := loop_03.cxx
LOOP_03_ID := 1sWlr-4BxFrffVExUlhV-sKNmvINUtj44
LOOP_03_URL := "https://drive.usercontent.google.com/download?id=$(LOOP_03_ID)&confirm=t"

$(LOOP_03_FNAME):
	wget --output-document=./$(LOOP_03_FNAME) $(LOOP_03_URL)

task1-03: task1-03-lp task1-03a task1-03b task1-03c
	@echo "$@ done"

task1-03-lp: $(LOOP_03_FNAME) $(ROOT_E_FNAME)
	root -t -q -l -x $(LOOP_03_FNAME)

task1-03a:
	@echo "$@: Tree name: ntTracks. Specified at line 38 of the source"

task1-03b:
	@echo "$@: Momentum components are distributed gaussian-like; change distribution is discrete with only +-1 actually occuring"

task1-03c:
	@echo "$@: There were more tracks with positive charge"


LOOP_04_FNAME := loop_04.cxx
LOOP_04_ID := 1RUNoNW6wTJy7pGcay3Ti4p9ydo7Kcs0l
LOOP_04_URL := "https://drive.usercontent.google.com/download?id=$(LOOP_04_ID)&confirm=t"
LOOP_04_FNAME_MODIFIED := loop_04_modified.cxx

$(LOOP_04_FNAME):
	wget --output-document=./$(LOOP_04_FNAME) $(LOOP_04_URL)
	# omg, there's stack smashing going on!
	sed -i "s/t_t tr\[4/t_t tr\[5/g" $(LOOP_04_FNAME)

task1-04: task1-04-lp task1-04a task1-04b task1-04c
	echo "$@ done"

task1-04-lp: $(LOOP_04_FNAME) $(ROOT_E_FNAME)
	@echo "Initial launch"
	root -t -q -l -x $(LOOP_04_FNAME)
	@echo "Uncomment limit"
	cat $(LOOP_04_FNAME) | sed -r 's/\/\/ (if\(Trk_ntracks>50\) continue;)/\1/g' 1> $(LOOP_04_FNAME_MODIFIED)
	@echo "Launch modified loop"
	root -t -q -l -x $(LOOP_04_FNAME_MODIFIED)

task1-04a:
	@echo "$@: Naturally, after track count limit was uncommented, there are no events with more than 50 tracks."

task1-04b:
	@echo "$@: Output file is named \"./output_example_cuts.root\""

task1-04c:

# --------

LOOP_05_FNAME := loop_05.cxx
LOOP_05_ID := 19fQxgnBrcicuihAdhaZq_C2JBXNUoKTj
LOOP_05_URL := "https://drive.usercontent.google.com/download?id=$(LOOP_05_ID)&confirm=t"

$(LOOP_05_FNAME):
	wget --output-document=./$(LOOP_05_FNAME) $(LOOP_05_URL)
	# comment erroneous line out
	sed -i -r "s/(Float_t phi=0.0;)/\/\/ \1/g" $(LOOP_05_FNAME)

task2: task2-lp task2-sc
	echo "$@ done"

task2-lp: $(LOOP_05_FNAME) $(ROOT_E_FNAME)
	root -t -q -l -x $(LOOP_05_FNAME)

task2-sc: $(ROOT_E_FNAME)
	root -t -q -l -x 'task2.cxx("${ROOT_E_FNAME}", "${ROOT_E_TNAME}")'

# --------

BEAMS_FNAME := beam_spot.cxx
BEAMS_ID := 1-FIcP0Xd4TpkAcGq7K1XPIwtdll3yQpq
BEAMS_URL := "https://drive.usercontent.google.com/download?id=$(BEAMS_ID)&confirm=t"

$(BEAMS_FNAME):
	wget --output-document=./$(BEAMS_FNAME) $(BEAMS_URL)
	# replace non-existend dataset with already-present one
	sed -i "s/data_06e_59933_59933_01.root/${ROOT_P_FNAME}/g" $(BEAMS_FNAME)

ROOT_P_FNAME := data_06p_60005_60010_01.root
ROOT_P_ID := 1GG16naUVvapNNSqWDfgTL9voWy1XlihK
ROOT_P_URL := "https://drive.usercontent.google.com/download?id=$(ROOT_P_ID)&confirm=t"

$(ROOT_P_FNAME):
	wget --output-document=./$(ROOT_P_FNAME) $(ROOT_P_URL)

ROOT_P_TNAME := orange

task3: task3-a task3-4b
	@echo "$@: done"

task3-sc: $(BEAMS_FNAME) $(ROOT_P_FNAME)
	root -t -l -x $(BEAMS_FNAME)

MIN_Z ?= 0
task3-bm: $(ROOT_P_FNAME)
	root -t -l -x 'beams.cxx($(MAX_Z), $(MIN_Z))'

task3-a:
	@echo "$@: a general shape would be elipse-like, although it's actual shape might be quite complicated"

task3-4b:
	@echo "$@: approximate X width: 0.3 (cm) = 300 (mcm)"
	@echo "$@: approximate Y width: 0.003 (cm) = 30 (mcm)"

# -------

task4: task4-pre task4-0 task4-1 task4-2
	@echo "$@: done"

task4-pre:
	@echo "$@: (c=1) m^2 = E^2 - p^2"

MASS_FNAME := inv_mass_jpsi.cxx
MASS_ID := 1PiWf62LS39s8rWgYzOp7LYqdu17Zcc2h
MASS_URL := "https://drive.usercontent.google.com/download?id=$(MASS_ID)&confirm=t"

$(MASS_FNAME):
	wget --output-document=./$(MASS_FNAME) $(MASS_URL)
	# replace non-existend dataset with already-present one
	sed -i "s/data_06e_59933_59933_01.root/${ROOT_P_FNAME}/g" $(MASS_FNAME)
	# remove erroneous declarations
	sed -i "0,/Int_t  Trk_layout/s//\/\/ Int_t  Trk_layout/" $(MASS_FNAME)
	sed -i -r "s/nt_tracks->SetBranchAddress\(\"Trk_layouter\"\, Trk_layouter\)/\/\/ nt_tracks->SetBranchAddress\(\"Trk_layouter\"\, Trk_layouter\)/g" $(MASS_FNAME)
	# fix bad variable type
	sed -i "s/Float_t  Muqual[50];/Int_t  Muqual[50];/g" $(MASS_FNAME)

task4-0:
	@echo "$@: muon mass ~~= 105.6 MeV"

task4-1:
	@echo "$@: was done in 1st lab"
	@echo "$@: output file is named jpsi_out.root"
	@echo "$@: there will be jpsi_mass, nmu, p1, p2 and jpsi_p leaves in the output"


task4-sc: $(ROOT_P_FNAME) $(MASS_FNAME)
	root -t -l -x -q $(MASS_FNAME)

CORR ?= 1.0
INVMASS_FOUT := jpsi_out.root
task4-im: $(ROOT_P_FNAME) $(ROOT_E_FNAME)
	root -t -l -x -q 'invmass.cxx("$(ROOT_P_FNAME)", "$(ROOT_E_FNAME)", "$(INVMASS_FOUT)", "$(ROOT_P_TNAME)", $(CORR))'

task4-2: task4-im
	@echo "$@: to load both files, we can add them one after each other"
	@echo "$@: alternatively, shell expand syntax is supported, for some reason"

task5: task5-1 task5-2 task5-3 task5-4 task5-5

ROOT_K0_FNAME := k0_61747_49.root
ROOT_K0_ID := 1ipg6IyYJj4DdEKFv8-ZJm7ewOI32zzBJ
ROOT_K0_URL := "https://drive.usercontent.google.com/download?id=$(ROOT_K0_ID)&confirm=t"

$(ROOT_K0_FNAME):
	wget --output-document=./$(ROOT_K0_FNAME) $(ROOT_K0_URL)

task5-1:
	@echo "$@: there are a lot of parameters in the file"
	@echo "$@: tree's name is ntK0"
	@echo "$@: there are 70011 events in the file"
	@echo "$@: each event represents a single reconstructed K0 creation+decay event"

MASS_BINS ?= 300
task5-ms: $(ROOT_K0_FNAME)
	root -t -l -x 'task5_mass.cxx("$(ROOT_K0_FNAME)", $(MASS_BINS))'

task5-2:
	@echo "$@: make task5-ms"

task5-3:
	@echo "$@: omg, I have no idea, wtf is this task"

K0_FNAME := k0_ctau_1.cxx
K0_ID := 1SLR_mhzaUmX-zeXpoGzSJOk4zneZ2yv4
K0_URL := "https://drive.usercontent.google.com/download?id=$(K0_ID)&confirm=t"

$(K0_FNAME):
	wget --output-document=./$(K0_FNAME) $(K0_URL)
	# append some code needed for task5-4
	sed -i 's/^}/\tprintf("Peak sum: %.2f\\n", sumpeak);\n\tFloat_t sumall = f_sum1->Integral(gaus_range0, gaus_range1) \/ coef1;\n\tauto sumbg = sumall - sumpeak;\n\tprintf("Bg sum: %.2f\\nSignal\/Bg ratio: %.3f\\n", sumbg, sumpeak \/ sumbg);\n}/g' $(K0_FNAME)

task5-k0: $(K0_FNAME) $(ROOT_K0_FNAME)
	root -t -l -x $(K0_FNAME)

task5-4: $(K0_FNAME) $(ROOT_K0_FNAME)
	@echo "$@: fit ranges seem to be specifiedd at lines 22 and 24 respectively"
	@echo "$@: fit functions seem to be defined at 38 and 42 respectively"
	@echo "$@: Integral function(?) doen't seem to take in argument for bin width, so I have no idea where from would it take it. But, actuall code in line 45 seems to imply, that bin width is at 'coef1' variable. That would be around 1.16 MeV"

task5-5:
	@echo "$@: in case there is an object with the same name, root seems to replace it without any checks. That would be an actual memory leak, if variable names are only defined by a name itself, without any sanitization.\nLines 13-16 should mitigate it, by removing previously-present objects"
	
# -------

task6: task6-0 task6-1 task6-2 task6-3

DIS0_FNAME := select_DIS_00.cxx
DIS0_ID := 1T9T35eZDM0rWozjovx6LG2m0j4OEYOW7
DIS0_URL := "https://drive.usercontent.google.com/download?id=$(DIS0_ID)&confirm=t"

$(DIS0_FNAME):
	wget --output-document=./$(DIS0_FNAME) $(DIS0_URL)
	# replace non-existend dataset with already-present one
	sed -i "s/data_06e_59933_59933_01.root/${ROOT_P_FNAME}/g" $(DIS0_FNAME)

task6-0: $(DIS0_FNAME) $(ROOT_E_FNAME)
	# root -t -l -x -q $(DIS0_FNAME)
	@echo "$@: $(DIS0_FNAME) contains a bunch of NULL-chars, not sure what is that about"

DIS1_FNAME := select_DIS_01.cxx
DIS1_ID := 1or35030ojnTM-D6aOE9EAdj3r_RA1sHi
DIS1_URL := "https://drive.usercontent.google.com/download?id=$(DIS1_ID)&confirm=t"

$(DIS1_FNAME):
	wget --output-document=./$(DIS1_FNAME) $(DIS1_URL)
	# replace non-existend dataset with already-present one
	sed -i "s/data_06e_59933_59933_01.root/${ROOT_E_FNAME}/g" $(DIS1_FNAME)

task6-1: $(DIS1_FNAME) $(ROOT_E_FNAME)
	-root -t -l -x -q $(DIS1_FNAME)
	@echo "$@: Observation - only first 1000 events are used. So first cut cuts about 600 events via parameter 'Sincand'"

DIS2_FNAME := select_DIS_02.cxx
DIS2_ID := 1O9EpfrzbW8VY6CqTcP_3QmXGuaVbu7cp
DIS2_URL := "https://drive.usercontent.google.com/download?id=$(DIS2_ID)&confirm=t"

$(DIS2_FNAME):
	wget --output-document=./$(DIS2_FNAME) $(DIS2_URL)
	# replace non-existend dataset with already-present one
	sed -i "s/data_06e_59933_59933_01.root/${ROOT_E_FNAME}/g" $(DIS2_FNAME)

task6-2: $(DIS2_FNAME) $(ROOT_E_FNAME)
	-root -t -l -x -q $(DIS2_FNAME)
	@echo "$@: electron elergy defore scattering is more than 10GeV (?)"
	@echo "$@: 337 events satisfy both conditions"

DIS3_FNAME := select_DIS_03.cxx
DIS3_ID := 12m_JiNLZRJqNP3vNvgfj_4QC9ApPq1hA
DIS3_URL := "https://drive.usercontent.google.com/download?id=$(DIS3_ID)&confirm=t"

$(DIS3_FNAME):
	wget --output-document=./$(DIS3_FNAME) $(DIS3_URL)
	# replace non-existend dataset with already-present one
	sed -i "s/data_06e_59933_59933_01.root/${ROOT_E_FNAME}/g" $(DIS3_FNAME)

task6-3: $(DIS3_FNAME) $(ROOT_E_FNAME)
	-root -t -l -x -q $(DIS3_FNAME)
	@echo "$@: in out program, Q^2 inn [10.; 350.]"

# -------

task7: task7-sc task7-1 task7-2 task7-3 task7-4 task7-5 task7-6

TGE_FNAME := k0_ctau_TGraphErorrs_6.cxx
TGE_ID := 1ypPYx4WqOHWSj8FUbkFnuNKnx6HAn6ye
TGE_URL := "https://drive.usercontent.google.com/download?id=$(TGE_ID)&confirm=t"

$(TGE_FNAME):
	wget --output-document=./$(TGE_FNAME) $(TGE_URL)
	# add 'auto' before first appearance of some variables
	sed -i "0,/f_sum1/s/f_sum1/auto f_sum1/" $(TGE_FNAME)
	sed -i "0,/f_g=/s/f_g=/auto f_g = /" $(TGE_FNAME)
	# use proper output syntax
	sed -i '/^cout<</c \\tprintf("\\tsum[%d] = %3.3f +- %3.3f\\n", kk, sum[kk], e_sum[kk]);' $(TGE_FNAME)
	# patch fancy visuals
	patch $(TGE_FNAME) ./task7_format.patch

task7-sc: $(TGE_FNAME) $(ROOT_K0_FNAME)
	root -t -l -x $(TGE_FNAME)

task7-1:
	@echo "$@: can't identify it. there's too much implicit syntax"

task7-2:
	@echo "$@: lines 63-64 seem to correspond to that"

task7-3:
	@echo "$@: corresponding patch is applied after file's download"

task7-4:
	@echo "$@: line 72 seem to correspond to that"

task7-5:
	@echo "$@: 'TGraphErrors(n,x,y,ex,ey)', where 'x', 'y', 'ex' and 'ey' are expected to be pointers to memory of size 'sizeof(Double_t) * n'"

task7-6:
	@echo "$@: Corresponding patch applied after file's donwload"

# -------

MIN_CTAU ?= 0.0
MAX_CTAU ?= 20.0
MIN_FIT ?= 1.0
MAX_FIT ?= 18.0
NBINS ?= 100
task8: $(ROOT_K0_FNAME)
	root -t -l -x 'task8.cxx("./k0_61747_49.root", "ntK0", $(MIN_FIT), $(MAX_FIT), $(MIN_CTAU), $(MAX_CTAU), $(NBINS))'

PROTOCOL_FNAME := protocol.pdf
PROTOCOL_SOURCE :=  $(OBSIDIAN_WIKI)/ff/LBE/protocol.md
PROTOCOL_PROFNAME ?= MISSING

protocol.md: $(PROTOCOL_SOURCE)
	# bring actual protocol
	-rm protocol.md
	cp $(PROTOCOL_SOURCE) protocol.md
	# refresh images folder
	-rm -rf ./images
	mkdir -v ./images
	# find all images in the protocol. I've only used obsidian-formatted insert images: ![[Pasted image <TIMESPAMP>.png]]
	for i in $(PROTOCOL_IMAGES); do cp -v $(OBSIDIAN_WIKI)/attachments/Pasted\ image\ $$i.png ./images/; done
	
protocol.pdf: protocol.md ./images/
	# replace prof
	sed 's/PROF_UNIQUE_VARIABLE/$(PROTOCOL_PROFNAME)/g' protocol.md > protocol_tmp.md
	# compile
	kyomato-helper.bash ./protocol_tmp.md
	mv protocol_tmp.pdf protocol.pdf
	rm protocol_tmp.md

PROTOCOL_IMAGES := $$(grep -E -o --color=never '!\[\[Pasted image [0-9]+\.png\]\]' ./protocol.md | grep -E -o --color=never '[0-9]+')
