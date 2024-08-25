import { LightningElement,api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

export default class LightningRecordForm extends LightningElement {
    fields = [NAME_FIELD,PHONE_FIELD];


    //@api recordId;
   // @api objectApiName;
}