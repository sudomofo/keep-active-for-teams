const STORAGE_KEY = "tka_enabled";

const toggle = document.getElementById("toggle");
const stateLabel = document.getElementById("stateLabel");
const status = document.getElementById("status");

function renderState(enabled) {
  toggle.checked = enabled;
  stateLabel.textContent = enabled ? "On" : "Off";
}

async function checkTeamsTab() {
  try {
    const tabs = await chrome.tabs.query({
      url: ["https://teams.microsoft.com/*", "https://teams.live.com/*"]
    });
    if (tabs.length === 0) {
      status.classList.add("warn");
      status.textContent = "No Microsoft Teams tab is open — open teams.microsoft.com for this to take effect.";
    } else {
      status.classList.remove("warn");
      status.textContent = `Active on ${tabs.length} Teams tab${tabs.length === 1 ? "" : "s"}.`;
    }
  } catch (err) {
    status.textContent = "";
  }
}

chrome.storage.local.get({ [STORAGE_KEY]: false }, (data) => {
  renderState(Boolean(data[STORAGE_KEY]));
});

toggle.addEventListener("change", () => {
  const enabled = toggle.checked;
  chrome.storage.local.set({ [STORAGE_KEY]: enabled }, () => {
    renderState(enabled);
    checkTeamsTab();
  });
});

checkTeamsTab();

// Open the Buy Me a Coffee link in a new tab via the tabs API,
// which is more reliable in MV3 popups than relying on target="_blank".
const bmc = document.getElementById("bmc");
bmc.addEventListener("click", (e) => {
  e.preventDefault();
  chrome.tabs.create({ url: bmc.href });
  window.close();
});
