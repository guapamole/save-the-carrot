import { Controller } from '@hotwired/stimulus';
import { createConsumer } from '@rails/actioncable';

export default class extends Controller {
  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: 'ResultsChannel' },
      { received: (data) => this._handleData(data) }
    );
  }

  _handleData(data) {
    data.forEach((item) => {
      this.element.insertAdjacentHTML('beforeend', item.name);
    });
  }
}
