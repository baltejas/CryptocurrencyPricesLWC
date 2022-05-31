import { LightningElement, wire } from 'lwc';
import getLivePrices from '@salesforce/apex/CryptoPriceController.getLivePrices';

const columns = [
    { label: 'Name', fieldName: 'name' },
    { label: 'Symbol', fieldName: 'symbol'},
    { label: 'Price', fieldName: 'price'},
    { label: '24h Change', fieldName: 'percent_change_24h'}
];

export default class Crypto extends LightningElement {

    columns = columns;

    @wire(getLivePrices)
    coinPrices;

    get coinPricesDefined () {
        return this.coinPrices !== undefined && this.coinPrices.data !== undefined
    }
}