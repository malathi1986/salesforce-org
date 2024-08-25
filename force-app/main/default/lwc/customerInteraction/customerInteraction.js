import { LightningElement, wire } from 'lwc';
import accountActivation from '@salesforce/messageChannel/AccountActivation__c';
import { publish, MessageContext } from 'lightning/messageService';


export default class CustomerInteraction extends LightningElement {
    customerComments

    @wire(MessageContext) msgContext;

    updateCustomerStatus(){

        var inp=this.template.querySelector("lightning-input-rich-text");
        this.searchText=inp.value;
        const payload = { activationComments: inp.value};
        publish(this.msgContext, accountActivation, payload);

    }
}