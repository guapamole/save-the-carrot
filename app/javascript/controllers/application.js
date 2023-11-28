import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience+
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener("DOMContentLoaded", function() {
  var quantityField = document.getElementById("ingredient-quantity");
  var decrementButton = document.querySelector(".quantity-decrement");
  var incrementButton = document.querySelector(".quantity-increment");

  decrementButton.addEventListener("click", function() {
    if (quantityField.value > 0) {
      quantityField.stepDown();
    }
  });

  incrementButton.addEventListener("click", function() {
    quantityField.stepUp();
  });
});
