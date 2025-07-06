import "@hotwired/turbo-rails"
import "preline"
import "./controllers"

document.addEventListener("turbo:load", () => {
  window.HSStaticMethods?.autoInit?.();
  window.HSOverlay?.autoInit?.();
});