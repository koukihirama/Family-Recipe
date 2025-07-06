import "@hotwired/turbo-rails"
import "preline"
import "./controllers"


document.addEventListener("turbo:load", () => {
  // Prelineの再初期化
  window.HSStaticMethods?.autoInit?.();

  const menu = document.getElementById("mobile-menu");

  if (menu) {
    // メニューを毎回リセット（遷移後の残留対策）
    menu.classList.add("hidden");

    // 古いイベントを削除してから再登録（重要！）
    const newCloseBtn = menu.querySelector(".custom-close-btn");
    const newOpenBtn = document.querySelector("[data-hs-overlay='#mobile-menu']");

    // 古いイベントを削除するため、一度クローンを使って置き換える
    if (newCloseBtn) {
      const clonedCloseBtn = newCloseBtn.cloneNode(true);
      newCloseBtn.parentNode.replaceChild(clonedCloseBtn, newCloseBtn);
      clonedCloseBtn.addEventListener("click", () => {
        menu.classList.add("hidden");
      });
    }

    if (newOpenBtn) {
      const clonedOpenBtn = newOpenBtn.cloneNode(true);
      newOpenBtn.parentNode.replaceChild(clonedOpenBtn, newOpenBtn);
      clonedOpenBtn.addEventListener("click", () => {
        menu.classList.remove("hidden");
      });
    }
  }
});
