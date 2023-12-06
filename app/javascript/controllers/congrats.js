import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["congrats"]

  displayCongrats() {
    this.congratsTarget.classList.remove("hidden");
  }
}
