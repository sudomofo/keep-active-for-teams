---
title: Privacy Policy
layout: default
---

# Privacy Policy — Keep Active for Teams

_Last updated: 2026-05-29_

Keep Active for Teams ("the extension") is a Chrome / Edge browser extension that prevents the Microsoft Teams web client from showing an idle status by dispatching synthetic input events on the Teams tab. This document describes everything the extension does — and does not — with your data.

## TL;DR

The extension stores **one boolean** (your On/Off toggle) in your browser's local extension storage. Nothing is transmitted anywhere. There are no servers, no analytics, no tracking, no accounts.

## Data we collect

**None that leaves your browser.**

The only piece of state the extension reads or writes is a single boolean named `tka_enabled`, stored via the browser's [`chrome.storage.local`](https://developer.chrome.com/docs/extensions/reference/api/storage) API. This value represents whether you have the activity simulator toggled On or Off. It is stored locally and is never sent over the network.

We do not collect or process:

- Personally identifiable information
- Authentication information (passwords, tokens, cookies)
- Personal communications (messages, emails, calls)
- Financial or payment information
- Health information
- Location
- Web browsing history
- User activity (clicks, keystrokes, mouse movements)
- The content of any web page, including Microsoft Teams

## Permissions, and why we need each one

| Permission | Why |
|---|---|
| `storage` | To remember your On/Off toggle across browser restarts. Stored locally only. |
| `tabs` | So the popup can tell you whether you currently have a Microsoft Teams tab open. We read the count of matching tabs only — never page content, never other URLs. |
| Host access to `https://teams.microsoft.com/*` and `https://teams.live.com/*` | The activity-simulator content script must run on the Teams tab to dispatch `mousemove` and `keydown` events. It runs on no other site. |

## Third parties

The extension makes no network requests of its own and does not include any third-party SDKs, analytics, advertising, or telemetry.

If you click the "Buy me a coffee" link in the popup, your browser opens [buymeacoffee.com](https://buymeacoffee.com/sudomofo) in a new tab. From that point your interaction with Buy Me a Coffee is governed by **their** privacy policy, not ours.

## Remote code

The extension does not load or execute any remotely-hosted code. All JavaScript is bundled into the published package and reviewed by the Chrome Web Store as part of the listing.

## Children

The extension is not directed to children under 13 and does not knowingly collect data from anyone, regardless of age.

## Changes to this policy

If this policy changes, the "Last updated" date at the top of the page will change too, and the new version will be published at the same URL.

## Contact

Questions or concerns? Email **syabubakar@gmail.com**.
