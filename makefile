
.PHONY: clean
clean:
	-rm tasks.pdf

.PHONY: download
download: tasks.pdf

TASKS_ID := 1Na83v679SGG0BeOCS22yW2SRjxna2xA8
TASKS_URL := https://drive.usercontent.google.com/download?id=$(TASKS_ID)&export=download
tasks.pdf:
	wget -q --output-document=./tasks.pdf $(TASKS_URL)

