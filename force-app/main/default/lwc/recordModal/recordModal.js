import { api } from 'lwc';
import LightningModal from 'lightning/modal';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import BILLING_COUNTRY from '@salesforce/schema/Account.BillingCountry';
import Id from '@salesforce/schema/Account.Id';


export default class RecordModal extends LightningModal {
    @api
    fields = [NAME_FIELD,BILLING_COUNTRY,Id];

    // Flexipage provides recordId and objectApiName
    @api options;
 
}