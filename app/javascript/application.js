import "@hotwired/turbo-rails"
import "preline"
import "./controllers"


document.addEventListener("turbo:load", () => {
  // Prelineの再初期化
  window.HSStaticMethods?.autoInit?.();

  const menu = document.getElementById("mobile-menu");

  // ✅ 保険としてオーバーレイを強制的に隠す（遷移後の残留対策）
  if (menu) {
    menu.classList.add("hidden");
  }

  // ✕ ボタンの自作動作
  const closeBtn = document.querySelector("#mobile-menu .custom-close-btn");
  if (closeBtn && menu) {
    closeBtn.addEventListener("click", () => {
      menu.classList.add("hidden");
    });
  }

  // 開くトグルボタン（Prelineのもの）
  const openBtn = document.querySelector("[data-hs-overlay='#mobile-menu']");
  if (openBtn && menu) {
    openBtn.addEventListener("click", () => {
      menu.classList.remove("hidden");
    });
  }
});