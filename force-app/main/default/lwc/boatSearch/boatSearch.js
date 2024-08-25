// imports
 import { NavigationMixin } from 'lightning/navigation';
 import {LightningElement, track} from 'lwc';
 export default class BoatSearch extends NavigationMixin(LightningElement){
    isLoading = false;
    @track
    boatTypeId;
    // Handles loading event
    handleLoading() { 
        this.isLoading = true;
    }
    
    // Handles done loading event
    handleDoneLoading() { 
        this.isLoading = false;
    }
    
    // Handles search boat event
    // This custom event comes from the form
    
    searchBoats(event) {
        let boatTypeId=event.detail.boatTypeId;
        console.log('boatTypeId>>>>>',boatTypeId)
        this.template.querySelector('c-boat-search-results').searchBoats(boatTypeId);

     }
    
    createNewBoat() { 
       
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Boat__c',
                    actionName: 'new'
                },
            });
        
    }
}