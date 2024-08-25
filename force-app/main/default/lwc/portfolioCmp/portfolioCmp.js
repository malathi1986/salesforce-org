import { LightningElement,track } from 'lwc';
import getAcctsByCountry from '@salesforce/apex/PortfolioUtility.getAccountsByCountry';
import getRelatedListForSelectedAcct from '@salesforce/apex/PortfolioUtility.getRelatedListForSelectedAcct';
//import { NavigationMixin } from 'lightning/navigation';
import MyModal from 'c/recordModal';
import relatedModel from 'c/relatedListRecordModal';
//import MyModal from 'lightning/modal'

const actions = [
    { label: 'View', name: 'view' },
    { label: 'View Related', name: 'View RelatedList' }
 ];

const columns = [
    { label: 'Id', fieldName: 'Id',type: 'text'},
    { label: 'Name', fieldName: 'Name',type: 'text'},
    { label: 'BillingCountry', fieldName: 'BillingCountry',type: 'text'},
    { type: 'action',typeAttributes: {rowActions: actions,menuAlignment: 'right' }}
];



export default class PortfolioCmp extends LightningElement{

    @track allCheckBox
    @track relatedlistCheckBox
    @track countryName
    @track relatedList
    @track data = [];
    @track columns = columns;
    @track acctIdsArr=[];
    @track relatedlistArr=[];
    @track relatedData=[];
    
    changeHandler(){
        let allCheckBox = this.template.querySelectorAll(".country");
        console.log("this is the event=====>"+ allCheckBox);
        let countryArr = [];
        allCheckBox.forEach((checkbox) => {     
            console.log("this is the event=====>"+ checkbox.name);
            if(checkbox.checked === true){
                countryArr.push(checkbox.name);
                console.log("calling Apex Method.... ");
            }     
        })
        console.log('countryArr ===', JSON.stringify(countryArr));
        getAcctsByCountry({
            countryName : countryArr
        }).then(result => {
            let tempData = [];
            result.forEach((record) => {    
                console.log("Record for datatable=====>"+ record.Id); 
                tempData.push({Id:record.Id,Name:record.Name,BillingCountry:record.BillingCountry}); 
            })
            console.log("data.... ", JSON.stringify(tempData));
            this.data = tempData;
        })
        .catch(error => {
            console.log("calling Apex Method.... ", error);
        });
        
    }
    relatedListHandler(){
        let relatedlistCheckBox = this.template.querySelectorAll(".RelatedList");
        console.log("this is the event=====>"+ relatedlistCheckBox);

        relatedlistCheckBox.forEach((checkbox) => {     
            console.log("this is the event=====>"+ checkbox.name);
            if(checkbox.checked === true){
                this.relatedlistArr.push(checkbox.name);
                //console.log("calling Apex Method.... ");
            }     

        });
        
        
}
    
handleRowAction(event) {
    console.log('Event details....',JSON.stringify(event));
    const action= event.detail.action.name;
    const row = event.detail.row;
    // open up the Modal
    if(action==="view"){
        MyModal.open({
            size: 'medium',
            heading: 'Navigate to Record Page',
            description: 'Navigate to a record page by clicking the row button',
            label:'Launch Navigation Modal',
            options: {Id:row.Id,ObjectName : 'Account'},
        });
    }
    if(action==="View RelatedList"){
        let selectedAcctIds=[];
        //console.log('row ====', JSON.stringify(event))
        let acctRecord= event.detail.row.Id;
        //console.log('acctRecord ====', JSON.stringify(acctRecord))
        
        selectedAcctIds.push(acctRecord);
        console.log('selectedAcctIds ====', JSON.stringify(selectedAcctIds))
    
        this.acctIdsArr=selectedAcctIds;

        console.log("values of relatedListArr.... ",JSON.stringify(this.relatedlistArr));
        console.log("values of acctIdsArr......",this.acctIdsArr);

        getRelatedListForSelectedAcct({
            relatedList : this.relatedlistArr,
            acctIds: this.acctIdsArr
        }).then(result => {
                console.log("Json output "+JSON.stringify(result));
                relatedModel.open({
                    size: 'medium',
                    heading: 'Navigate to Record Page',
                    description: 'Navigate to a record page by clicking the row button',
                    label:'Launch Navigation Modal',
                    options: result
                });
                
            })
            .catch(error => {
                console.log("calling Apex Method.... ", error);
            });      
            
    }    
}
}