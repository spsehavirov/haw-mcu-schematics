# =======================================
# TikZ Diagram Generator (PDF/PNG/SVG)
#
# Required tools:
# - pdflatex (TeX Live)
# - pdftocairo (from poppler-utils)
#
# Linux install:
#   sudo apt install texlive-latex-base poppler-utils
#
# macOS install (Homebrew):
#   brew install basictex poppler
#   sudo tlmgr install standalone xcolor etoolbox xstring
#
# Usage:
#   make all           # Build all PDFs
#   make analog        # Build one scenario (PDF)
#   make analog.png    # Build PNG
#   make analog.svg    # Build SVG
#   make images        # Build all PNG + SVG
#   make clean         # Delete all generated files
# =======================================

TEMPLATE := ad_conversion_universal.tex
CFG_DIR := cfg
DIST_DIR := dist

PDF_DIR := $(DIST_DIR)/pdf
PNG_DIR := $(DIST_DIR)/png
SVG_DIR := $(DIST_DIR)/svg

SCENARIOS := $(notdir $(basename $(wildcard $(CFG_DIR)/*.cfg)))
PDFS := $(addprefix $(PDF_DIR)/,$(addsuffix .pdf,$(SCENARIOS)))
PNGS := $(addprefix $(PNG_DIR)/,$(addsuffix .png,$(SCENARIOS)))
P_FL := $(addprefix $(PNG_DIR)/,$(addsuffix _flat.png,$(SCENARIOS))) # Flat PNG
SVGS := $(addprefix $(SVG_DIR)/,$(addsuffix .svg,$(SCENARIOS)))

ifeq ($(shell uname), Darwin)
    SED_INPLACE = sed -i ''
else
    SED_INPLACE = sed -i
endif

all: pdfs
pdfs: $(PDFS)
pngs: $(PNGS)
svgs: $(SVGS)
pngs_flat: $(P_FL)
images: pngs pngs_flat svgs

# Aliases like: make analog
$(SCENARIOS): %: $(PDF_DIR)/%.pdf

# PDF target
$(PDF_DIR)/%.pdf: $(TEMPLATE) $(CFG_DIR)/%.cfg | $(PDF_DIR)
	@echo "🔧 Building PDF: $@"
	@cp $(TEMPLATE) $(PDF_DIR)/$*.tex
	@while IFS='=' read -r key val; do \
		if [ -n "$$key" ]; then \
			sed -i.bak "s|\\\\newcommand{\\\\$${key}}{[^}]*}|\\\\newcommand{\\\\$${key}}{$${val}}|g" $(PDF_DIR)/$*.tex; \
		fi; \
	done < $(CFG_DIR)/$*.cfg
#	@echo "🔍 Modified config lines:" && grep '\\newcommand' $(PDF_DIR)/$*.tex | echo "🔁 Replacing $$key = $$val";
	@pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(PDF_DIR) $(PDF_DIR)/$*.tex >/dev/null
	@rm -f $(PDF_DIR)/$*.aux $(PDF_DIR)/$*.log
	@rm -f $(PDF_DIR)/$*.tex $(PDF_DIR)/$*.tex.bak

# PNG from PDF
# Transparent PNG (default)
$(DIST_DIR)/png/%.png: $(DIST_DIR)/pdf/%.pdf | $(PNG_DIR)
	@echo "🖼️  Generating PNG: $@"
	@pdftocairo -png -transp -singlefile -r 600 $< $(basename $@)

# White background PNG (_flat version)
$(DIST_DIR)/png/%_flat.png: $(DIST_DIR)/pdf/%.pdf | $(PNG_DIR)
	@echo "🖼️  Generating PNG (Flat variant): $@"
	@pdftocairo -png -r 600 -singlefile $< $(basename $@)

# SVG from PDF
$(SVG_DIR)/%.svg: $(PDF_DIR)/%.pdf | $(SVG_DIR)
	@echo "🔀 Generating SVG: $@"
	@pdftocairo -svg $< $@

# Ensure subdirectories exist
$(PDF_DIR) $(PNG_DIR) $(SVG_DIR):
	mkdir -p $@

clean:
	rm -rf $(DIST_DIR)

.PHONY: all clean pdfs pngs pngs_flat svgs images $(SCENARIOS)
