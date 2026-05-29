const STORAGE_KEY = "tka_enabled";

chrome.runtime.onInstalled.addListener(() => {
  chrome.storage.local.get({ [STORAGE_KEY]: false }, (data) => {
    updateBadge(Boolean(data[STORAGE_KEY]));
  });
});

chrome.runtime.onStartup.addListener(() => {
  chrome.storage.local.get({ [STORAGE_KEY]: false }, (data) => {
    updateBadge(Boolean(data[STORAGE_KEY]));
  });
});

chrome.storage.onChanged.addListener((changes, area) => {
  if (area !== "local" || !changes[STORAGE_KEY]) return;
  updateBadge(Boolean(changes[STORAGE_KEY].newValue));
});

function updateBadge(enabled) {
  chrome.action.setBadgeText({ text: enabled ? "ON" : "" });
  chrome.action.setBadgeBackgroundColor({ color: enabled ? "#1f8a4c" : "#888888" });
}
