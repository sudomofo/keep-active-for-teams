# Keep Active for Teams

A Chrome/Edge extension (Manifest V3) that keeps your Microsoft Teams status from going idle by dispatching periodic synthetic `mousemove` / `keydown` events on the Teams tab. A popup toggle turns it on or off, and the state is persisted.

## Files

```
teams-keep-active/
├── manifest.json   # MV3 manifest
├── background.js   # Service worker — manages badge state
├── content.js     # Runs on teams.microsoft.com / teams.live.com
├── popup.html     # Toggle UI
├── popup.js       # Toggle logic, writes to chrome.storage
└── icons/         # 16/32/48/128 px PNG icons
```

## Install (Chrome)

1. Open `chrome://extensions`.
2. Enable **Developer mode** (top right).
3. Click **Load unpacked** and select this `teams-keep-active/` folder.
4. Pin the extension. Open `https://teams.microsoft.com`, click the icon, flip the toggle to **On**.

## Install (Edge)

Same as Chrome but at `edge://extensions`.

## How it works

- The content script reads `tka_enabled` from `chrome.storage.local`. When `true`, it dispatches a `mousemove` and `keydown` (Shift) every 4 minutes on the Teams page — under Teams' ~5 minute idle threshold.
- The popup toggles `tka_enabled`. The content script subscribes to `chrome.storage.onChanged` and starts/stops the interval immediately on already-open Teams tabs.
- The service worker shows an **ON** badge on the toolbar icon while enabled.

## Notes

- Tab must stay open for the simulator to fire. The page being inactive/backgrounded is fine — `setInterval` still runs.
- If you reload Teams, the content script re-reads the persisted state and resumes automatically.
- Only operates on `teams.microsoft.com` and `teams.live.com`.
