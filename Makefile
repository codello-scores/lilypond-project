LILY= lilypond
LILY_OPTIONS=-ddelete-intermediate-files -dno-point-and-click

.SUFFIXES: .ly .ily .pdf .midi

LY_FILES = $(wildcard scores/*.ly)
PDF_FILES = $(LY_FILES:scores/%.ly=build/%.pdf)

.PHONY: all
all: $(PDF_FILES)

build/%.pdf %.pdf %.midi: scores/%.ly
	@echo "========== Compiling" $< "=========="
	mkdir -p $(shell dirname $@)
	@$(LILY) $(LILY_OPTIONS) --output $(basename $@) $<;
	@echo ""

.PHONY: clean
clean:
	rm -rf *.pdf scores/*.pdf build/

.PHONY: fonts
fonts:
	@echo "Obtaining Download Token"
	$(eval RESPONSE := $(shell echo "Test"))
	$(eval RESPONSE := $(shell curl -fsSL https://api.backblazeb2.com/b2api/v2/b2_authorize_account -u "${B2_KEY_ID}:${B2_APPLICATION_KEY}"))
	$(eval TOKEN := $(shell echo '${RESPONSE}' | jq -r .authorizationToken))
	$(eval URL := $(shell echo '${RESPONSE}' | jq -r .downloadUrl))
	@echo "Downloading Fonts"
	@curl -fsSL -H "Authorization: ${TOKEN}" "${URL}/file/Brewery/fonts/yorkten.zip" -o yorkten.zip
	@echo "Installing Fonts"
	@unzip -q yorkten.zip -d /usr/share/fonts/truetype
	@rm yorkten.zip

.PHONY: ci
ci: fonts all
