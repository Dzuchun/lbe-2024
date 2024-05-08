UNTRACKED_FNAMES = $(TASKS_FNAME) $(ROOT_E_FNAME) $(LOOP_01_FNAME) $(LOOP_02_FNAME) $(LOOP_03_FNAME) output_example.root $(LOOP_04_FNAME) $(LOOP_04_FNAME_MODIFIED) output_example_cuts.root $(LOOP_05_FNAME) $(BEAMS_FNAME)

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

task1-00a:
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
	sed -i "s/data_06e_59933_59933_01.root/${ROOT_E_FNAME}/g"

task3: task3-4b
	@echo "$@: done"

task3-bm: $(BEAMS_FNAME) $(ROOT_E_FNAME)
	root -t -q -l -x $(BEAMS_FNAME)

task3-4b:
	@echo "$@: approximate X width: 0.03 (cm) = 30 (mcm)"
	@echo "$@: approximate Y width: 0.003 (cm) = 3 (mcm)"

