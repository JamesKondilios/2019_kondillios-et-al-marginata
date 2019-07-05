html: methods.html
all: methods.pdf methods.html

%.html: %.md
	pandoc -o $@ $< --standalone
%.pdf: %.md
	pandoc -o $@ $< --standalone
