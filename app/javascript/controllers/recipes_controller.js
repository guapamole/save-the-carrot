import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="recipes"
export default class extends Controller {
  static targets = ["content"]

  connect() {
    // console.log(this.contentTarget)
    this.channel = createConsumer().subscriptions.create(
      { channel: "RecipesChannel" },
      { received: html => this.addContent(html) }
    )
  }

  addContent(html) {
    this.contentTarget.innerHTML = html;
  }
}
