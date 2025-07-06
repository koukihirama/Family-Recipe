import "@hotwired/turbo-rails"
import "preline"
import "./controllers"

// Turbo遷移ごとにPrelineを再初期化
document.addEventListener("turbo:load", () => {
  window.HSStaticMethods?.autoInit?.(); // Preline の再初期化（必要）

  const menu = document.getElementById("mobile-menu");

  // 自作の ✕ ボタン動作（Preline が効かない時の保険）
  const closeBtn = document.querySelector("#mobile-menu .custom-close-btn");
  if (closeBtn && menu) {
    closeBtn.addEventListener("click", () => {
      menu.classList.add("hidden");
    });
  }

  // トグルボタン（開く）
  const openBtn = document.querySelector("[data-hs-overlay='#mobile-menu']");
  if (openBtn && menu) {
    openBtn.addEventListener("click", () => {
      menu.classList.remove("hidden");
    });
  }
});