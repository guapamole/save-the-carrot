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

  _handleData(data) {
    this.resultsData = data;
    data.forEach((item) => {
      this.element.insertAdjacentHTML("beforeend", `${item.name}<br>`);
    });
  }

    validateButtonClick() {
      this.addResultsToContainer(this.resultsData);
      window.location.href = "/ingredients";
    }

  addResultsToContainer(results) {
    const container = document.getElementById('results-container');

    if (Array.isArray(results)) {
      results.forEach((item) => {
        const resultElement = document.createElement("p");
        resultElement.textContent = "${item.name}";
        container.appendChild(resultElement);
      });
    }
  }
}
