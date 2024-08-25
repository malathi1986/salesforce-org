import { LightningElement, api } from 'lwc';
export default class recordFormOne extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields = ['AccountId', 'Name', 'Title', 'Phone', 'accessories__c','Active__c','CustomerPriority__c'];
}