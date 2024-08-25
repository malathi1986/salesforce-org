import { api,track } from 'lwc';
import LightningModal from 'lightning/modal';

const columns = [
    { label: 'Id', fieldName: 'Id',type: 'text'},
    { label: 'Name', fieldName: 'Name',type: 'text'}
];

export default class RelatedListRecordModal extends LightningModal {
    @track columns = columns;
    @api
    options
  
}