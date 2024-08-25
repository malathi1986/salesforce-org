import { LightningElement,wire} from 'lwc';
import { subscribe, MessageContext,APPLICATION_SCOPE } from 'lightning/messageService';
import accountActivation from '@salesforce/messageChannel/AccountActivation__c';

export default class CustomerCurrentStatus extends LightningElement {

    @wire(MessageContext)
    messageContext;
    customerMessage

    // Encapsulate logic for Lightning message service subscribe and unsubsubscribe
    subscribeToMessageChannel() {
        if (!this.subscription) {
            this.subscription = subscribe(
                this.messageContext,
                accountActivation,
                (message) => this.handleMessage(message),
                { scope: APPLICATION_SCOPE }
            );
        }
    }

    unsubscribeToMessageChannel() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    // Handler for message received by component
    handleMessage(message) {
        console.log('message >>>', message);
        this.customerMessage = message.activationComments;
    }

    // Standard lifecycle hooks used to subscribe and unsubsubscribe to the message channel
    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    disconnectedCallback() {
        this.unsubscribeToMessageChannel();
    }

    // Helper
    dispatchToast(error) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error loading contact',
                message: reduceErrors(error).join(', '),
                variant: 'error'
            })
        );
    }

}