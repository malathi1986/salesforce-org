import { LightningElement, api } from 'lwc';
export default class LoadRecordLDS extends LightningElement {
    @api recordId;
    @api objectApiName;
    fields = ['AccountId', 'Name', 'Title', 'Phone', 'Email'];
}