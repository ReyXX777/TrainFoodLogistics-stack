import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { inject as service } from '@ember/service';

export default class OrderPageComponent extends Component {
  @service socket;  // Phoenix Channels integration
  @tracked orderStatus = 'pending';
  @tracked eta = null;

  constructor() {
    super(...arguments);
    this.setupSocket();
  }

  setupSocket() {
    let channel = this.socket.channel('orders:lobby', {});
    
    channel.join()
      .receive('ok', () => {
        console.log('Connected to order channel');
      });

    channel.on('order_update', payload => {
      this.orderStatus = payload.order.status;
      this.eta = payload.order.eta;
    });
  }

  @action
  placeOrder(itemName, quantity) {
    // API call to backend for order creation
    fetch('/api/orders', {
      method: 'POST',
      body: JSON.stringify({
        order: { item_name: itemName, quantity: quantity }
      })
    }).then(response => response.json())
      .then(data => {
        this.eta = data.eta;
      });
  }
}
