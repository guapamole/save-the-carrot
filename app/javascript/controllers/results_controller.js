import { Controller } from '@hotwired/stimulus';
import { createConsumer } from '@rails/actioncable';

export default class extends Controller {
  connect() {
    this.resultsData = [];
    this.channel = createConsumer().subscriptions.create(
      { channel: 'ResultsChannel' },
      { received: (data) => this._handleData(data) }
    );

    document.getElementById("validate-fridge-button").addEventListener('click', () => {
      this.validateButtonClick();
    });
  }

  _handleData(html) {
    document.querySelector('#results-container').innerHTML = html;
  }

  validateButtonClick() {
    window.location.href = "/ingredients";
  }

  async add(evt) {
    evt.preventDefault();
    evt.stopPropagation();

    const options = {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content
      }
    };

    const response = await fetch(`/ingredients/add?ingredient_name=${evt.params.ingredientName}`, options);
    const data = await response.json();
    console.log(data)
  }
}
