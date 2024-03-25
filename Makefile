LILY= lilypond
LILY_OPTIONS=-ddelete-intermediate-files -dno-point-and-click

.SUFFIXES: .ly .ily .pdf .midi

LY_FILES = $(wildcard scores/*.ly)
PDF_FILES = $(LY_FILES:scores/%.ly=build/%.pdf)

.PHONY: all
all: $(PDF_FILES)

build/%.pdf %.pdf %.midi: scores/%.ly
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
	rm -rf *.pdf scores/*.pdf build/
