# Keep Active for Teams

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](#license)
[![Manifest V3](https://img.shields.io/badge/manifest-v3-6264a7.svg)](https://developer.chrome.com/docs/extensions/mv3/intro/)
[![Privacy Policy](https://img.shields.io/badge/privacy-policy-1f8a4c.svg)](https://sudomofo.github.io/keep-active-for-teams/)
[![Buy Me A Coffee](https://img.shields.io/badge/Buy%20Me%20A%20Coffee-FFDD00?logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/sudomofo)

A Chrome / Edge extension (Manifest V3) that keeps your Microsoft Teams web status from going idle by dispatching periodic synthetic `mousemove` / `keydown` events on the Teams tab. A popup toggle turns it on or off, and the state is persisted across browser restarts.

> **Not affiliated with Microsoft.** "Microsoft Teams" is a trademark of Microsoft Corporation. This extension is an independent project.

## Files

```
keep-active-for-teams/
├── manifest.json       # MV3 manifest
├── background.js       # Service worker — manages the ON badge
├── content.js          # Runs on teams.microsoft.com / teams.live.com
├── popup.html          # Toggle UI
├── popup.js            # Toggle logic, writes to chrome.storage
├── icons/              # 16 / 32 / 48 / 128 px PNG icons
├── docs/               # GitHub Pages source for the privacy policy
├── marketing/          # Store assets (promo tile, screenshot template)
├── Makefile            # `make zip` to build the upload artefact
├── STORE_LISTING.md    # Chrome Web Store listing copy
└── EDGE_LISTING.md     # Microsoft Edge Add-ons listing copy
```

## Install (developer mode)

### Chrome

1. Open `chrome://extensions`.
2. Enable **Developer mode** (top right).
3. Click **Load unpacked** and select this folder.
4. Pin the extension. Open `https://teams.microsoft.com`, click the icon, flip the toggle to **On**.

### Edge

Same as Chrome but at `edge://extensions`.

## Build the upload artefact

```sh
make zip
```

Produces `dist/keep-active-for-teams-v<version>.zip` containing only the runtime files (manifest, JS, HTML, icons) — no markdown, no docs, no marketing. Upload that zip to the Chrome Web Store or Edge Add-ons Partner Center.

## How it works

- The content script reads `tka_enabled` from `chrome.storage.local`. When `true`, it dispatches a `mousemove` and a `keydown` (Shift) every 4 minutes on the Teams page — just under Teams' ~5 minute idle threshold.
- The popup toggles `tka_enabled`. The content script subscribes to `chrome.storage.onChanged` and starts/stops the interval immediately on already-open Teams tabs.
- The service worker shows an **ON** badge on the toolbar icon while enabled.

## Privacy

No data leaves your browser. The extension stores a single boolean (your On/Off toggle) via `chrome.storage.local`. No analytics, no tracking, no remote code. See the full [Privacy Policy](https://sudomofo.github.io/keep-active-for-teams/).

## Notes

- The Teams tab must stay open for the simulator to fire. The tab being backgrounded is fine — `setInterval` still runs in MV3 content scripts as long as the page is alive.
- If you reload Teams, the content script re-reads the persisted state and resumes automatically.
- Operates only on `teams.microsoft.com` and `teams.live.com`.

## Support the project

If this saved you from one too many "Away" pings, you can [buy me a coffee ☕](https://buymeacoffee.com/sudomofo).

<a href="https://buymeacoffee.com/sudomofo" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" height="50" />
</a>

## License

MIT — see [LICENSE](LICENSE) if present, otherwise treat as MIT.
