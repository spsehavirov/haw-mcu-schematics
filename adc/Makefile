# ==============================================================================
# TikZ Diagram Builder
#
# Converts a LaTeX TikZ file into multiple formats:
#   - PDF (cropped)
#   - PNG (transparent background)
#   - PNG flat (white background)
#   - SVG (vector for web)
#
# Requirements:
#   - pdflatex
#   - pdftocairo (part of poppler-utils)
#
# Usage:
#   make               # Build all outputs from TEX
#   make clean         # Delete dist/ folder and all generated outputs
#   make TEX=yourfile.tex  # Build from a different .tex input
# ==============================================================================

TEX       ?= adc_ideal.tex
BASENAME  := $(basename $(notdir $(TEX)))

DIST_DIR  := dist
PDF_DIR   := $(DIST_DIR)/pdf
PNG_DIR   := $(DIST_DIR)/png
SVG_DIR   := $(DIST_DIR)/svg

PDF_OUT   := $(PDF_DIR)/$(BASENAME).pdf
PNG_OUT   := $(PNG_DIR)/$(BASENAME).png
PNG_FLAT  := $(PNG_DIR)/$(BASENAME)_flat.png
SVG_OUT   := $(SVG_DIR)/$(BASENAME).svg

.PHONY: all clean

all: $(PDF_OUT) $(PNG_OUT) $(PNG_FLAT) $(SVG_OUT)

# --- Build PDF ---
$(PDF_OUT): $(TEX) | $(PDF_DIR)
	@echo "🔧 [PDF] Building: $@"
	@pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(PDF_DIR) $(TEX) > /dev/null
	@rm -f $(PDF_DIR)/$(BASENAME).aux $(PDF_DIR)/$(BASENAME).log

# --- PNG (Transparent Background) ---
$(PNG_OUT): $(PDF_OUT) | $(PNG_DIR)
	@echo "🖼️  [PNG] Transparent: $@"
	@pdftocairo -png -transp -singlefile -r 600 $< $(basename $@)

# --- PNG (Flat / White Background) ---
$(PNG_FLAT): $(PDF_OUT) | $(PNG_DIR)
	@echo "🖼️  [PNG] Flat: $@"
	@pdftocairo -png -r 600 -singlefile $< $(basename $@)

# --- SVG ---
$(SVG_OUT): $(PDF_OUT) | $(SVG_DIR)
	@echo "🔀 [SVG] Generating: $@"
	@pdftocairo -svg $< $@

# --- Directory creation ---
$(PDF_DIR) $(PNG_DIR) $(SVG_DIR):
	@mkdir -p $@

# --- Clean ---
clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -rf $(DIST_DIR)
