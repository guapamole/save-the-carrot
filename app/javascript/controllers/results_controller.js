import { Controller } from '@hotwired/stimulus';
import { createConsumer } from '@rails/actioncable';

export default class extends Controller {
  connect() {
    this.resultsData = [];
    this.channel = createConsumer().subscriptions.create(
      { channel: 'ResultsChannel' },
      { received: (data) => this._handleData(data) }
    );

    document.getElementById('validate-button').addEventListener('click', () => {
      this.validateButtonClick();
    });
  }

  _handleData(data) {
    this.resultsData = data;
    data.forEach((item) => {
      this.element.insertAdjacentHTML('beforeend', `${item.name}<br>`);
    });
  }

  validateButtonClick() {
    this.addResultsToContainer(this.resultsData)
      .then(() => {
        window.location.href = "/ingredients";
      })
      .catch((error) => {

        console.error(error);
      });
  }

  addResultsToContainer(results) {
    return new Promise((resolve, reject) => {
      const container = document.getElementById('results-container');

      if (Array.isArray(results)) {
        if (results.length > 0) {
          results.forEach((item) => {
            const resultElement = document.createElement('p');
            resultElement.textContent = `${item.name}`;
            container.appendChild(resultElement);
          });

          resolve();
        }
    });
  }
}
