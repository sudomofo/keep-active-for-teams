# Chrome Web Store — Listing Copy

Paste each section into the corresponding field in the Developer Dashboard.

---

## Name (max 45 chars)

```
Keep Active for Teams
```
*(20 chars — well under the limit, avoids leading "Microsoft" trademark concern.)*

---

## Short description (max 132 chars)

```
Stops your Microsoft Teams status from going idle. One-click toggle, runs only on Teams tabs, no data ever leaves your browser.
```
*(127 chars.)*

---

## Detailed description

```
Keep Active for Teams stops your Microsoft Teams web status from flipping to "Away" when you step away briefly. While the toggle is On, it dispatches a synthetic mousemove and Shift keydown on the Teams tab every 4 minutes — just under Teams' ~5 minute idle threshold — so your status stays Available.

FEATURES
• One-click On/Off toggle in the popup
• Works on teams.microsoft.com and teams.live.com
• "ON" badge on the toolbar icon while active
• Setting persists across browser restarts
• Pauses immediately when toggled off — no reload needed
• No accounts, no analytics, no tracking, no data leaves your browser

HOW TO USE
1. Open Microsoft Teams in your browser.
2. Click the extension icon in the toolbar.
3. Flip the switch to On.
4. Leave the Teams tab open. Your status stays Available.

PERMISSIONS, IN PLAIN ENGLISH
• Storage — remembers your On/Off setting.
• Tabs — lets the popup tell you whether a Teams tab is currently open.
• Host access to teams.microsoft.com / teams.live.com — the activity simulator runs only on those pages, nowhere else.

PRIVACY
This extension does not collect personal information, does not transmit any data over the network, and does not use analytics or remote code. The only thing it stores is a single boolean (your On/Off toggle) in your browser's local extension storage.

NOT AFFILIATED WITH MICROSOFT
This is an independent project and is not affiliated with, endorsed by, or sponsored by Microsoft Corporation. "Microsoft Teams" is a trademark of Microsoft Corporation.

SUPPORT
If this saved you from one too many "Away" pings, you can buy me a coffee at https://buymeacoffee.com/sudomofo. The link is also in the popup.
```

---

## Category

```
Productivity / Workflow & Planning
```

---

## Language

```
English (United States)
```

---

## Single-purpose description (Privacy practices tab)

```
The single purpose of this extension is to keep the Microsoft Teams web client from showing an idle ("Away") status by simulating user input on the Teams tab while the user has the toggle enabled.
```

---

## Permission justifications (Privacy practices tab)

**`storage`**
```
Used to persist the user's On/Off toggle so the setting survives browser restarts. Stored locally via chrome.storage.local. Never transmitted.
```

**`tabs`**
```
Used in the popup only, to check whether the user currently has a Microsoft Teams tab open. This lets the popup show "Active on N Teams tabs" or a hint to open Teams. No tab content, URLs of other sites, or browsing history is read or stored.
```

**Host permissions — `https://teams.microsoft.com/*`, `https://teams.live.com/*`**
```
The activity-simulator content script must run on the user's Microsoft Teams tab to dispatch mousemove and keydown events that prevent the idle timer from firing. These are the only sites the extension injects into.
```

**Remote code use**
```
No. The extension contains no remotely-hosted code. All JavaScript is bundled in the package and reviewed by you.
```

**Data collection / use disclosures**
- Personally identifiable information — **Not collected**
- Health information — **Not collected**
- Financial / payment information — **Not collected**
- Authentication information — **Not collected**
- Personal communications — **Not collected**
- Location — **Not collected**
- Web history — **Not collected**
- User activity — **Not collected**
- Website content — **Not collected**

Certifications:
- ✅ I do not sell or transfer user data to third parties outside of the approved use cases.
- ✅ I do not use or transfer user data for purposes unrelated to my item's single purpose.
- ✅ I do not use or transfer user data to determine creditworthiness or for lending purposes.

---

## Privacy policy URL

Published via GitHub Pages from [`docs/index.md`](docs/index.md):

```
https://sudomofo.github.io/keep-active-for-teams/
```

Paste that URL into the "Privacy policy" field of the Developer Dashboard.

---

## Distribution

- Visibility: **Public**
- Regions: **All regions** (or restrict as you wish)
- Pricing: **Free**

---

## Required image assets

| Asset | Size | Where to use |
|---|---|---|
| Icon | 128×128 PNG | already in `icons/icon128.png` |
| Screenshots (1–5) | 1280×800 or 640×400 PNG/JPG | at minimum: (1) popup open over a Teams tab, (2) Teams tab with toolbar badge showing "ON" |
| Small promo tile | 440×280 PNG | required, for the store grid |
| Marquee promo tile | 1400×560 PNG | optional, only if you want to be considered for featuring |

**Trademark safety for images:** crop screenshots so the Microsoft / Teams logo is not the primary focus, and don't use Microsoft branding in your promo tiles. Your own purple-square-with-T icon is fine.

---

## Pre-submit checklist

- [ ] Bumped `version` in [manifest.json](manifest.json) if this is a resubmission
- [ ] Zipped the **contents** of `teams-keep-active/` (manifest at root of zip)
- [ ] Privacy policy is live at a public URL
- [ ] Single-purpose statement + permission justifications pasted
- [ ] At least one screenshot uploaded
- [ ] 440×280 small promo tile uploaded
- [ ] Distribution set to Public, region/pricing chosen
