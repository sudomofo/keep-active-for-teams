NAME    := keep-active-for-teams
VERSION := $(shell python3 -c "import json; print(json.load(open('manifest.json'))['version'])")
DIST    := dist
ZIP     := $(DIST)/$(NAME)-v$(VERSION).zip

# Only these paths go into the upload artefact.
RUNTIME := manifest.json background.js content.js popup.html popup.js icons

PRIVACY_URL := https://sudomofo.github.io/keep-active-for-teams/
REPO_URL    := https://github.com/sudomofo/keep-active-for-teams
BMC_URL     := https://buymeacoffee.com/sudomofo

.DEFAULT_GOAL := help

.PHONY: help zip clean version check submit

help:
	@echo "Keep Active for Teams — build targets"
	@echo ""
	@echo "  make zip      Build $(ZIP) for Chrome Web Store / Edge Add-ons upload"
	@echo "  make check    Sanity-check the built artefact and store assets"
	@echo "  make submit   Print step-by-step Chrome + Edge submission checklist"
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

# ----------------------------------------------------------------------
# check — verify everything a reviewer will look at, before you submit.
# Exits non-zero if anything required is missing.
# ----------------------------------------------------------------------
check:
	@echo "▶ Checking submission readiness for v$(VERSION)…"
	@echo ""
	@missing=0; \
	check_file() { \
	  if [ -f "$$1" ]; then \
	    size=$$(ls -lh "$$1" | awk '{print $$5}'); \
	    printf "  ✅ %-45s  %s\n" "$$1" "$$size"; \
	  else \
	    printf "  ❌ %-45s  MISSING\n" "$$1"; \
	    missing=$$((missing + 1)); \
	  fi; \
	}; \
	echo "Runtime files:"; \
	for f in $(RUNTIME); do \
	  if [ -d "$$f" ]; then \
	    for g in $$f/*; do check_file "$$g"; done; \
	  else \
	    check_file "$$f"; \
	  fi; \
	done; \
	echo ""; \
	echo "Store assets:"; \
	check_file "marketing/promo-tile-440x280.png"; \
	check_file "marketing/marquee-promo-tile-1400x560.png"; \
	check_file "marketing/screenshot-1280x800.png"; \
	check_file "marketing/screenshot-1366x768.png"; \
	check_file "marketing/edge-store-logo-300x300.png"; \
	echo ""; \
	echo "Documentation:"; \
	check_file "STORE_LISTING.md"; \
	check_file "EDGE_LISTING.md"; \
	check_file "docs/index.md"; \
	check_file "LICENSE"; \
	echo ""; \
	echo "Privacy policy URL:"; \
	if command -v curl >/dev/null 2>&1; then \
	  code=$$(curl -s -o /dev/null -w "%{http_code}" "$(PRIVACY_URL)"); \
	  if [ "$$code" = "200" ]; then \
	    printf "  ✅ %-45s  HTTP %s\n" "$(PRIVACY_URL)" "$$code"; \
	  else \
	    printf "  ❌ %-45s  HTTP %s\n" "$(PRIVACY_URL)" "$$code"; \
	    missing=$$((missing + 1)); \
	  fi; \
	else \
	  printf "  ⚠️  curl not available — check %s manually\n" "$(PRIVACY_URL)"; \
	fi; \
	echo ""; \
	if [ -f "$(ZIP)" ]; then \
	  printf "Build artefact: ✅ %s\n" "$(ZIP)"; \
	else \
	  printf "Build artefact: ⚠️  not built yet — run \`make zip\`\n"; \
	fi; \
	echo ""; \
	if [ $$missing -gt 0 ]; then \
	  echo "❌ $$missing missing item(s). Resolve before submitting."; \
	  exit 1; \
	else \
	  echo "✅ All checks passed. You're ready — run \`make submit\` for the checklist."; \
	fi

# ----------------------------------------------------------------------
# submit — interactive(ish) step-by-step submission walkthrough.
# Prints copy-pasteable values and the order to do them in.
# ----------------------------------------------------------------------
submit:
	@printf "\033[1m═══════════════════════════════════════════════════════════════════\033[0m\n"
	@printf "\033[1m  Keep Active for Teams — submission checklist (v$(VERSION))\033[0m\n"
	@printf "\033[1m═══════════════════════════════════════════════════════════════════\033[0m\n"
	@echo ""
	@printf "\033[1m▶ Step 0 — pre-flight\033[0m\n"
	@echo "    □ Bump version in manifest.json if this is an UPDATE (not first submit)"
	@echo "    □ Commit + push to GitHub:   git push"
	@echo "    □ Build the artefact:        make zip"
	@echo "    □ Verify everything:         make check"
	@echo ""
	@printf "\033[1m▶ Step 1 — Chrome Web Store\033[0m\n"
	@echo "    URL:  https://chrome.google.com/webstore/devconsole"
	@echo ""
	@echo "    1. Click 'New item' (or pick existing item for an update)."
	@echo "    2. Upload: $(ZIP)"
	@echo "    3. Store listing tab — paste from STORE_LISTING.md:"
	@echo "         • Name, short description, detailed description"
	@echo "         • Category: Productivity"
	@echo "         • Language: English (United States)"
	@echo "         • Upload icon (icons/icon128.png)"
	@echo "         • Upload promo tile (marketing/promo-tile-440x280.png)"
	@echo "         • Upload ≥1 screenshot (marketing/screenshot-1280x800.png)"
	@echo "    4. Privacy practices tab — paste from STORE_LISTING.md:"
	@echo "         • Single purpose statement"
	@echo "         • Permission justifications (storage, tabs, host)"
	@echo "         • Remote code: No"
	@echo "         • Data collection: none of the checkboxes"
	@echo "         • Privacy policy URL:  $(PRIVACY_URL)"
	@echo "         • Tick all three certifications"
	@echo "    5. Distribution tab:"
	@echo "         • Visibility: Public"
	@echo "         • Regions: All"
	@echo "         • Pricing: Free"
	@echo "    6. Click 'Submit for review'."
	@echo "    7. First-review SLA is days to ~2 weeks; updates usually <72h."
	@echo ""
	@printf "\033[1m▶ Step 2 — Microsoft Edge Add-ons\033[0m\n"
	@echo "    URL:  https://partner.microsoft.com/dashboard/microsoftedge/overview"
	@echo ""
	@echo "    1. 'New extension' (or pick existing for update)."
	@echo "    2. Upload: $(ZIP)   (same zip as Chrome — MV3 is portable)"
	@echo "    3. Properties — paste from EDGE_LISTING.md:"
	@echo "         • Category: Productivity"
	@echo "         • Privacy policy URL:  $(PRIVACY_URL)"
	@echo "         • Support contact email"
	@echo "         • Permissions justification (Edge has a dedicated field!)"
	@echo "    4. Store listing — paste from EDGE_LISTING.md:"
	@echo "         • Display name, short description, description"
	@echo "         • Search terms (≤7)"
	@echo "         • Upload store logo (marketing/edge-store-logo-300x300.png)"
	@echo "         • Upload promo tile (marketing/promo-tile-440x280.png)"
	@echo "         • Upload screenshot at 1366×768 (marketing/screenshot-1366x768.png)"
	@echo "    5. Availability:  Public, all markets, Free"
	@echo "    6. Notes for certification reviewers — PASTE the test-steps block"
	@echo "       from EDGE_LISTING.md. Microsoft reviewers reject without it."
	@echo "    7. 'Publish'.   Edge review usually completes in 1–3 business days."
	@echo ""
	@printf "\033[1m▶ Step 3 — after both stores approve\033[0m\n"
	@echo "    □ Tag the release:     git tag -a v$(VERSION) -m 'v$(VERSION)' && git push --tags"
	@echo "    □ Create a GitHub Release with the same zip attached"
	@echo "    □ Add the live Chrome + Edge store URLs to README.md badges"
	@echo "    □ Tell people about it — and link $(BMC_URL) 🙂"
	@echo ""
	@printf "\033[1m═══════════════════════════════════════════════════════════════════\033[0m\n"
	@echo "  Tip:  run \`make check\` first to confirm every asset is present."
	@printf "\033[1m═══════════════════════════════════════════════════════════════════\033[0m\n"
