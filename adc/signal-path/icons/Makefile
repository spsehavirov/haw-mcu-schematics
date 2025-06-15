SVG_FILES := $(wildcard *.svg)
PDF_DIR := pdf
PDF_FILES := $(patsubst %.svg,$(PDF_DIR)/%.pdf,$(SVG_FILES))

all: $(PDF_FILES)

$(PDF_DIR)/%.pdf: %.svg
	mkdir -p $(PDF_DIR)
	inkscape $< --export-background-opacity=0 --export-type=pdf --export-filename=$@

clean:
	rm -rf $(PDF_DIR)
