// imports
// import getBoatTypes from the BoatDataService => getBoatTypes method';
import {LightningElement, track, wire } from 'lwc';
import getBoatTypes from '@salesforce/apex/BoatDataService.getBoatTypes';
export default class BoatSearchForm extends LightningElement {
    @track
    selectedBoatTypeId = '';
    
    // Private
    lists=[];
    error = undefined;
    searchOptions;

    BoatSearchForm(){
        searchOptions = [];
    }
    
    @wire(getBoatTypes)
      boatTypes({ error, data }) {
      if (data) {
        this.searchOptions = data.map((type) => {
            return {label: type.Name, value: type.Id}
        });
        this.searchOptions.unshift({ label: 'All Types', value: '' });
      } 
      else if (error) {
        this.searchOptions = undefined;
        this.error = error;
        this.searchOptions.unshift({ label: 'All Types', value: '' });
      }
    }
    
    // Fires event that the search option has changed.
    // passes boatTypeId (value of this.selectedBoatTypeId) in the detail
    handleSearchOptionChange(event) {
    console.log('selectedBoatTypeId  ', this.selectedBoatTypeId)
    console.log('event  ', event)
    this.selectedBoatTypeId = event.detail.value;
    console.log('selectedBoatTypeId  ', this.selectedBoatTypeId)
      // Create the const searchEvent
      // searchEvent must be the new custom event search
      const searchEvent = new CustomEvent('search', { detail: { boatTypeId : this.selectedBoatTypeId}});
      this.dispatchEvent(searchEvent);
    }
  }