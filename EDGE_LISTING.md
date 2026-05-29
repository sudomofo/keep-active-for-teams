# Microsoft Edge Add-ons — Listing Copy

Submit at the [Microsoft Partner Center — Edge Add-ons dashboard](https://partner.microsoft.com/dashboard/microsoftedge/overview). Edge accepts the **same `dist/keep-active-for-teams-v1.0.0.zip`** you built for Chrome — Manifest V3 is portable. Paste each section into the corresponding field.

Most fields are similar to Chrome's listing; only the Edge-specific differences are flagged with **🆚 Edge-only** below.

---

## Product setup

| Field | Value |
|---|---|
| Product name | `Keep Active for Teams` |
| Default locale | `en-us` |

---

## Availability

| Field | Value |
|---|---|
| Visibility | **Public** |
| Markets | **All markets** (or restrict if you prefer) |
| Pricing | **Free** |
| 🆚 Discoverable in store | **Yes** |

---

## Properties

| Field | Value |
|---|---|
| Category | **Productivity** |
| Privacy policy URL | `https://sudomofo.github.io/keep-active-for-teams/` |
| Website (homepage) | `https://github.com/sudomofo/keep-active-for-teams` |
| Support contact (email) | `syabubakar@gmail.com` |
| Support website | `https://github.com/sudomofo/keep-active-for-teams/issues` |
| Mature content | **No** |

🆚 **Edge-only — "Permissions justification"** (free-text field in the Properties step):

```
storage: Persists the user's On/Off toggle across browser restarts via chrome.storage.local. The value never leaves the browser.

tabs: Used only inside the popup to count open Microsoft Teams tabs so the popup can show "Active on N Teams tabs" or prompt the user to open one. No tab URLs from other sites are read or stored.

Host permissions (teams.microsoft.com, teams.live.com): The activity-simulator content script runs only on these pages to dispatch mousemove and keydown events that prevent Teams' idle detection from firing. The extension injects into no other site.
```

---

## Store listing — `en-us`

### Display name (max 50 chars)

```
Keep Active for Teams
```

### Short description (max 200 chars)

```
Stops your Microsoft Teams web status from going idle. Simulates user activity on the Teams tab while a one-click toggle is enabled. No accounts, no analytics, no data ever leaves your browser.
```

### Description (max 10,000 chars)

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
This extension does not collect personal information, does not transmit any data over the network, and does not use analytics or remote code. The only thing it stores is a single boolean (your On/Off toggle) in your browser's local extension storage. Full privacy policy: https://sudomofo.github.io/keep-active-for-teams/

NOT AFFILIATED WITH MICROSOFT
This is an independent project and is not affiliated with, endorsed by, or sponsored by Microsoft Corporation. "Microsoft Teams" is a trademark of Microsoft Corporation.

SUPPORT
If this saved you from one too many "Away" pings, you can buy me a coffee at https://buymeacoffee.com/sudomofo. The link is also in the popup.

Source code: https://github.com/sudomofo/keep-active-for-teams
```

### Search terms (max 7, comma-separated)

```
teams, microsoft teams, active status, idle, away, keep active, do not disturb
```

🆚 **Edge-only — Search terms cap.** Edge limits you to seven; pick the seven most likely-typed queries.

### Store assets

| Asset | Size | Required? | Source |
|---|---|---|---|
| Store logo | **300×300 PNG** | yes | generate from your 128 icon — see note below |
| Small promotional tile | 440×280 PNG | yes | [marketing/promo-tile-440x280.png](marketing/promo-tile-440x280.png) |
| Large promotional tile | 1400×560 PNG | optional | generate if you want featuring |
| Screenshots | **1366×768 PNG/JPG**, 1–10 | yes | [marketing/screenshot-1280x800.png](marketing/screenshot-1280x800.png) (resize/pad to 1366×768 for Edge) |

🆚 **Edge-only screenshot resolution.** Chrome accepts 1280×800 but Edge expects **1366×768**. The included template is 1280×800 for Chrome — either re-export at 1366×768 or pad with white before uploading to Edge.

🆚 **Store logo (300×300).** Edge requires this specific size; Chrome only asks for 128×128. Generate one with:

```sh
python3 -c "from PIL import Image; \
img = Image.open('icons/icon128.png').resize((300, 300), Image.LANCZOS); \
img.save('marketing/edge-store-logo-300x300.png')"
```

---

## Notes & certifications (final submission step)

| Question | Answer |
|---|---|
| Single purpose | `Keeps the Microsoft Teams web client from showing an idle status by simulating user input on the Teams tab while the user has the toggle enabled.` |
| Does it use remote code? | **No** |
| Does it collect personal data? | **No** |
| Does it process payments? | **No** |
| Notes for certification reviewers | See block below |

### Notes for certification reviewers

```
Hi reviewer — quick context for testing:

1. Install the extension and pin the toolbar icon.
2. Open https://teams.microsoft.com in any tab (any signed-in account works; you do not need to wait for idle).
3. Click the extension icon. Flip the switch to On.
4. The popup will show "Active on 1 Teams tab" and the toolbar icon will gain an "ON" badge.
5. Open the Teams tab's DevTools console (F12). Every 4 minutes you should see a "[Keep Active for Teams] activity pulse" debug log. To verify immediately without waiting, the first pulse fires the moment you toggle On.

The extension makes no network requests of its own, contains no remote code, and stores only a single boolean (tka_enabled) via chrome.storage.local.

Source code is public at https://github.com/sudomofo/keep-active-for-teams
Privacy policy at https://sudomofo.github.io/keep-active-for-teams/

Thank you!
```

---

## Pre-submit checklist (Edge-specific)

- [ ] Built `dist/keep-active-for-teams-v1.0.0.zip` with `make zip`
- [ ] Generated 300×300 store logo (see snippet above)
- [ ] Re-exported screenshot at **1366×768** (Edge requires this, not 1280×800)
- [ ] Pasted permissions justification (Edge has a dedicated free-text field for this)
- [ ] Filled in the "Notes for certification reviewers" block — Microsoft reviewers are stricter than Chrome's and often reject without it
- [ ] Verified the privacy policy URL loads in an incognito window
