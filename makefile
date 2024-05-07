UNTRACKED_FNAMES = $(TASKS_FNAME) $(ROOT_E_FNAME) $(LOOP_01_FNAME) $(LOOP_02_FNAME)

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

.PHONY: task1 task1-00a task1-00b task-00c task-00d task-00-sc task-01 task-01a task-01b task-02 task-02a task-02b task-02c

ROOT_E_TNAME := orange

task1: task1-00a task1-00b task1-00c task1-00d task1-01 task1-01a task1-01b task1-02 task1-02a task1-02b task1-02c

task1-00a:
	echo "Tree name: ${ROOT_E_TNAME}(?)"

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

task1-01: $(LOOP_01_FNAME)
	root -x -q $(LOOP_01_FNAME)

task1-01a:
	echo "loop1 iterates through 10 first events"

task1-01b:
	# track numbers were 3 36 43 82 52 44 27 30 14
	echo "loop1 mentions 331 tracks total"

LOOP_02_FNAME := loop_02.cxx
LOOP_02_ID := 1H2Wo6wM02ax3eSaUGbl4DwOYW-P2dvej
LOOP_02_URL := "https://drive.usercontent.google.com/download?id=$(LOOP_02_ID)&confirm=t"

$(LOOP_02_FNAME):
	wget --output-document=./$(LOOP_02_FNAME) $(LOOP_02_URL)

task1-02: $(LOOP_02_FNAME)
	root -x -q $(LOOP_02_FNAME)

task1-02a: task1-02-sc

task1-02b: task1-02-sc

task1-02c: task1-02-sc

task1-02-sc: task1_02.cxx
	root -t -q -l -x 'task1_02.cxx("${ROOT_E_FNAME}", "${ROOT_E_TNAME}")'
