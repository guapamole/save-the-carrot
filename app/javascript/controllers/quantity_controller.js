import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quantity"
export default class extends Controller {
  connect() {
    console.log("Hello")
  }

  static targets = ["nombre"]

  increment(){
    let currentValue = parseInt(this.nombreTarget.value);
    this.nombreTarget.value = currentValue + 1;
    console.log("increment")
  }

  decrement(){
    let currentValue = parseInt(this.nombreTarget.value);
    this.nombreTarget.value = currentValue - 1;
    console.log("decrement")
  }
}
