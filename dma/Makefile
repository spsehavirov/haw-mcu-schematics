TEX_FILES := $(wildcard *.tex)
BASENAMES := $(basename $(notdir $(TEX_FILES)))

DIST_DIR := dist
PDF_DIR := $(DIST_DIR)/pdf
PNG_DIR := $(DIST_DIR)/png
SVG_DIR := $(DIST_DIR)/svg

PDFS := $(addprefix $(PDF_DIR)/,$(addsuffix .pdf,$(BASENAMES)))
PNGS := $(addprefix $(PNG_DIR)/,$(addsuffix .png,$(BASENAMES)))
P_FL := $(addprefix $(PNG_DIR)/,$(addsuffix _flat.png,$(BASENAMES)))
SVGS := $(addprefix $(SVG_DIR)/,$(addsuffix .svg,$(BASENAMES)))

STEPS := 0 1 2 3 4 5 6 7 8 9 10
STEP_PDFS := $(addprefix $(PDF_DIR)/dma_,$(addsuffix .pdf,$(STEPS)))

all: pdfs

pdfs: $(PDFS)
pngs: $(PNGS)
svgs: $(SVGS)
pngs_flat: $(P_FL)
images: pngs pngs_flat svgs
steps: $(STEP_PDFS)

$(PDF_DIR)/dma_%.pdf: dma.tex | $(PDF_DIR)
	@echo "🔧 Building DMA step $*"
	@pdflatex -interaction=nonstopmode -halt-on-error -jobname=dma_$* -output-directory=$(PDF_DIR) "\def\highlightstepvalue{$*} \input{dma.tex}" >/dev/null
	@rm -f $(PDF_DIR)/dma_$*.aux $(PDF_DIR)/dma_$*.log


$(BASENAMES): %: $(PDF_DIR)/%.pdf

$(PDF_DIR)/%.pdf: %.tex | $(PDF_DIR)
	@echo "🔧 Building PDF: $@"
	@pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(PDF_DIR) $< >/dev/null
	@rm -f $(PDF_DIR)/$*.aux $(PDF_DIR)/$*.log

$(PNG_DIR)/%.png: $(PDF_DIR)/%.pdf | $(PNG_DIR)
	@echo "🖼️  Generating PNG: $@"
	@pdftocairo -png -transp -singlefile -r 600 $< $(basename $@)

$(PNG_DIR)/%_flat.png: $(PDF_DIR)/%.pdf | $(PNG_DIR)
	@echo "🖼️  Generating PNG (Flat variant): $@"
	@pdftocairo -png -r 600 -singlefile $< $(basename $@)

$(SVG_DIR)/%.svg: $(PDF_DIR)/%.pdf | $(SVG_DIR)
	@echo "🔀 Generating SVG: $@"
	@pdftocairo -svg $< $@

$(PDF_DIR) $(PNG_DIR) $(SVG_DIR):
	mkdir -p $@

clean:
	rm -rf $(DIST_DIR)

.PHONY: all clean pdfs pngs pngs_flat svgs images $(BASENAMES)

