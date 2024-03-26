LILY= lilypond
LILY_OPTIONS=-ddelete-intermediate-files -dno-point-and-click

.SUFFIXES: .ly .ily .pdf .midi
SCORE_DIR ?= scores
BUILD_DIR ?= build

LY_FILES = $(wildcard $(SCORE_DIR)/*.ly)
PDF_FILES = $(LY_FILES:$(SCORE_DIR)/%.ly=$(BUILD_DIR)/%.pdf)

.PHONY: all
all: $(PDF_FILES)

$(BUILD_DIR)/%.pdf %.pdf %.midi: $(SCORE_DIR)/%.ly
ifdef GITHUB_ACTIONS
	@echo "::group::Compile $<"
else
	@echo "========== Compiling" $< "=========="
endif
	mkdir -p $(shell dirname $@)
	@$(LILY) $(LILY_OPTIONS) --output $(basename $@) $<;
ifdef GITHUB_ACTIONS
	@echo "::endgroup::"
else
	@echo ""
endif


.PHONY: clean
clean:
	rm -rf *.pdf $(SCORE_DIR)/*.pdf build/
