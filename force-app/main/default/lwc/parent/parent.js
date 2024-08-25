import { LightningElement } from 'lwc';

export default class Parent extends LightningElement {
    searchedText
    searchTextDisplayRed
    proocessSearchCompleteEvent(event){
        console.log('Event log ', JSON.stringify(event))
        console.log('Search event received and processed...', event.detail)
        if(event.detail.includes('illegal')){
            this.searchTextDisplayRed = true;
        } else {
            this.searchTextDisplayRed = false;
        }
        this.searchedText = event.detail;
    }
}