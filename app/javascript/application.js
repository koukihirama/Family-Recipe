import "@hotwired/turbo-rails"
import "preline"
import "./controllers"

// Turbo遷移ごとにPrelineを再初期化する
document.addEventListener("turbo:load", () => {
  window.HSStaticMethods?.autoInit?.();
});
