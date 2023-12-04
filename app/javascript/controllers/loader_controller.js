import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loader"
export default class extends Controller {

  static targets = [ "loader", "form" ]
  connect() {
  }

  displayLoader() {
    console.log(this.loaderTarget)
    this.loaderTarget.classList.remove("d-none")
    this.formTarget.submit()
  }
}
