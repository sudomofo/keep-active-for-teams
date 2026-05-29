NAME    := keep-active-for-teams
VERSION := $(shell python3 -c "import json; print(json.load(open('manifest.json'))['version'])")
DIST    := dist
ZIP     := $(DIST)/$(NAME)-v$(VERSION).zip

# Only these paths go into the upload artefact.
RUNTIME := manifest.json background.js content.js popup.html popup.js icons

.DEFAULT_GOAL := help

.PHONY: help zip clean version

help:
	@echo "Keep Active for Teams — build targets"
	@echo ""
	@echo "  make zip      Build $(ZIP) for Chrome Web Store / Edge Add-ons upload"
	@echo "  make clean    Remove $(DIST)/"
	@echo "  make version  Print the manifest version"
	@echo ""
	@echo "Current version: $(VERSION)"

version:
	@echo $(VERSION)

zip: clean
	@mkdir -p $(DIST)
	@zip -r "$(ZIP)" $(RUNTIME) -x "*.DS_Store" >/dev/null
	@echo "Built $(ZIP)"
	@ls -lh "$(ZIP)" | awk '{print "  size: " $$5}'
	@echo "  contents:"
	@unzip -l "$(ZIP)" | sed -n '4,$$p' | sed '$$d' | sed '$$d' | awk '{print "   " $$NF}'

clean:
	@rm -rf $(DIST)
