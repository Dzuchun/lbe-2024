UNTRACKED_FNAMES = $(TASKS_FNAME) $(ROOT_E_FNAME)

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

.PHONY: download
download: tasks.pdf dl-task1

TASKS_FNAME := tasks.pdf
TASKS_ID := 1Na83v679SGG0BeOCS22yW2SRjxna2xA8
TASKS_URL := "https://drive.usercontent.google.com/download?id=$(TASKS_ID)&export=download"
tasks.pdf:
	wget --output-document=./$(TASKS_FNAME) $(TASKS_URL)

ROOT_E_FNAME := data_06e_58207_58211_01.root
ROOT_E_ID := 1-jxowx7Cn8gjbBK4lGQwyiXMJRZx_c96
ROOT_E_URL := "https://drive.usercontent.google.com/download?id=$(ROOT_E_ID)&confirm=t"

.PHONY: dl-task1
dl-task1: $(ROOT_E_FNAME)

$(ROOT_E_FNAME):
	wget --output-document=./$(ROOT_E_FNAME) $(ROOT_E_URL)

