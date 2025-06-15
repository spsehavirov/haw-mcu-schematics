# =======================================
# TikZ Diagram Builder for signal_path.tex
#
# Requirements:
# - pdflatex
# - pdftocairo (from poppler-utils)
#
# Usage:
#   make           # Build all (PDF, PNG, flat PNG, SVG)
#   make clean     # Delete dist/
# =======================================

TEX := signal_path.tex
BASENAME := signal_path

DIST_DIR := dist
PDF_DIR := $(DIST_DIR)/pdf
PNG_DIR := $(DIST_DIR)/png
SVG_DIR := $(DIST_DIR)/svg

PDF_OUT := $(PDF_DIR)/$(BASENAME).pdf
PNG_OUT := $(PNG_DIR)/$(BASENAME).png
PNG_FLAT := $(PNG_DIR)/$(BASENAME)_flat.png
SVG_OUT := $(SVG_DIR)/$(BASENAME).svg

.PHONY: all clean

all: $(PDF_OUT) $(PNG_OUT) $(PNG_FLAT) $(SVG_OUT)

# --- PDF Build ---
$(PDF_OUT): $(TEX) | $(PDF_DIR)
	@echo "🔧 Building PDF: $@"
	@pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(PDF_DIR) $(TEX) >/dev/null
	@rm -f $(PDF_DIR)/$(BASENAME).aux $(PDF_DIR)/$(BASENAME).log

# --- PNG Transparent ---
$(PNG_OUT): $(PDF_OUT) | $(PNG_DIR)
	@echo "🖼️ Generating PNG: $@"
	@pdftocairo -png -transp -singlefile -r 600 $< $(basename $@)

# --- PNG Flat ---
$(PNG_FLAT): $(PDF_OUT) | $(PNG_DIR)
	@echo "🖼️ Generating PNG (Flat): $@"
	@pdftocairo -png -r 600 -singlefile $< $(basename $@)

# --- SVG ---
$(SVG_OUT): $(PDF_OUT) | $(SVG_DIR)
	@echo "🔀 Generating SVG: $@"
	@pdftocairo -svg $< $@

# --- Create Output Dirs ---
$(PDF_DIR) $(PNG_DIR) $(SVG_DIR):
	@mkdir -p $@

# --- Clean ---
clean:
	rm -rf $(DIST_DIR)
