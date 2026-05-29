(() => {
  const STORAGE_KEY = "tka_enabled";
  const INTERVAL_MS = 4 * 60 * 1000; // 4 minutes — under Teams' ~5 min idle threshold

  let timerId = null;

  function simulateActivity() {
    try {
      const x = Math.floor(Math.random() * window.innerWidth);
      const y = Math.floor(Math.random() * window.innerHeight);

      const move = new MouseEvent("mousemove", {
        view: window,
        bubbles: true,
        cancelable: true,
        clientX: x,
        clientY: y,
        screenX: x,
        screenY: y
      });
      document.body.dispatchEvent(move);

      // Also dispatch a keyboard event Teams may listen for, without producing input
      const key = new KeyboardEvent("keydown", {
        key: "Shift",
        code: "ShiftLeft",
        bubbles: true,
        cancelable: true
      });
      document.dispatchEvent(key);

      console.debug(
        `[Teams Keep Active] activity pulse @ ${new Date().toLocaleTimeString()}`
      );
    } catch (err) {
      console.warn("[Teams Keep Active] failed to dispatch activity:", err);
    }
  }

  function start() {
    if (timerId !== null) return;
    console.log("[Teams Keep Active] started");
    simulateActivity();
    timerId = setInterval(simulateActivity, INTERVAL_MS);
  }

  function stop() {
    if (timerId === null) return;
    console.log("[Teams Keep Active] stopped");
    clearInterval(timerId);
    timerId = null;
  }

  function apply(enabled) {
    if (enabled) start();
    else stop();
  }

  chrome.storage.local.get({ [STORAGE_KEY]: false }, (data) => {
    apply(Boolean(data[STORAGE_KEY]));
  });

  chrome.storage.onChanged.addListener((changes, area) => {
    if (area !== "local" || !changes[STORAGE_KEY]) return;
    apply(Boolean(changes[STORAGE_KEY].newValue));
  });
})();
