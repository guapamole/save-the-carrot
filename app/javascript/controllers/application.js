import { Application } from '@hotwired/stimulus';

const application = Application.start();

// Configure Stimulus development experience+
application.debug = false;
window.Stimulus = application;

export { application };

document.addEventListener("DOMContentLoaded", function() {
  let quantityField = document.querySelector(".ingredient-quantity");
  let decrementButton = document.querySelector(".quantity-decrement");
  let incrementButton = document.querySelector(".quantity-increment");

  decrementButton.addEventListener("click", function() {
    if (quantityField.value > 0) {
      quantityField.stepDown();
    }
  });

  incrementButton.addEventListener("click", function() {
    quantityField.stepUp();
  });
});
