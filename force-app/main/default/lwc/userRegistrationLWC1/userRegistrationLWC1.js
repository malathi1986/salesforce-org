import { LightningElement, track, wire } from 'lwc';
import registerUser from '@salesforce/apex/UserRegistrationAura.registerUser';
import validateIfUserNameExists from '@salesforce/apex/UserRegistrationAura.validateIfUserNameExists';
import getAllUserRegistrations from '@salesforce/apex/UserRegistrationAura.getAllUserRegistrations';
import deleteUserRegistrations from '@salesforce/apex/UserRegistrationAura.deleteUserRegistrations';
import { refreshApex } from '@salesforce/apex';
export default class UserRegistrationLWC extends LightningElement {

    firstName
    lastName
    primaryEmail
    userName
    password
    usernameExists
    tableData
    deletedRecord
    //wiredRegistrations
    selectedRecords=[];
    toBeDeletedRecordIds=[];
    @track errorMessage;
    
    actions = [
        { label: 'Edit', name: 'edit' },
        { label: 'Create', name: 'create' },
        { label: 'Delete', name: 'delete' }
    ];
    
    columns = [
        { label: 'First Name', fieldName: 'Firstname__c', type : 'text' },
        { label: 'Last Name', fieldName: 'Lastname__c', type: 'text' },
        { label: 'Primary Email', fieldName: 'Email__c', type: 'text' },
        { label: 'User Name', fieldName: 'User_Name__c', type: 'text' },
        { label: 'Password', fieldName: 'Password__c', type: 'text' },
        { label: 'Action',fieldName:'action', type: 'action', typeAttributes: { rowActions: this.actions} }
    ];
    //@wire to get the values from apex class methods and wire it to a component @wire(apexMethodName, { apexMethodParams }) propertyOrFunction;
    ///@wire(getAllUserRegistrations) tableData;
 
    @wire(getAllUserRegistrations)
    wiredRegistrations({ error, data }) {
    
        if (data) {
            this.tableData = data;
            this.error = undefined;
            console.log('data >>>>>',JSON.stringify(data))
            //this.tableData = data;
        } else if (error) {
            //this.error = error1;
            this.tableData = undefined;
            console.log('error >>>>>',JSON.stringify(error))
        }   
    }

    handleRowAction(event) {
        console.log('Event details....',JSON.stringify(event))
        const action = event.detail.action;
        const row = event.detail.row;
        switch (action.name) {
            case 'edit':
                console.log('Showing Details: ' + JSON.stringify(row));
                this.firstName=row.Firstname__c;
                this.lastName = row.Lastname__c;
                this.primaryEmail = row.Email__c;
                this.userName = row.User_Name__c;
                this.password = row.Password__c;
                break;
            case 'delete':
                const rows = [...this.tableData];
                let matchedIndex;
                let recordId;
                for (let index = 0; index <this.tableData.length; index++) {
                    let element = this.tableData[index];
                    if (element.Firstname__c===row.Firstname__c && 
                        element.Lastname__c===row.Lastname__c && 
                        element.Email__c===row.Email__c &&
                        element.User_Name__c===row.User_Name__c &&
                        element.Password__c===row.Password__c) {
                        matchedIndex=index;
                        console.log('match found....')
                        recordId = element.Id;
                        break;
                    }      
                }
                let recordToBeDeleted = [recordId];  

                deleteUserRegistrations({ 
                    userRegistrationIds : recordToBeDeleted
                    })
                    .then((result) => {
                        this.deletedRecord = result;
                        console.log('deletedRecord===>'+JSON.stringify(row))
                    })
                    .catch((error) => {
                        this.deletedRecord = error.body.message;
                    });

                rows.splice(matchedIndex, 1);
                this.tableData = rows;
                break;
        }
    }

    validateUserName(event){

        validateIfUserNameExists({ 
            userName : event.target.value
            })
            .then((result) => {
                this.usernameExists = result;
            })
            .catch((error) => {
                this.usernameExists = error.body.message;
            });
    }

    handleSave() {

        var inputElementsArray=this.template.querySelectorAll("lightning-input");
        inputElementsArray.forEach( 
            function(element){
            if(element.name=="firstName"){
                this.firstName=element.value;
            }
            if(element.name=="lastName"){
                this.lastName=element.value;
            }
            if(element.name=="primaryEmail"){
                this.primaryEmail=element.value;
            }
            if(element.name=="userName"){
                this.userName=element.value;
            }
            if(element.name=="password"){
                this.password=element.value;
            }
        }
        
        ,this);

        registerUser({ firstName: this.firstName,
            lastName : this.lastName,
            primaryEmail : this.primaryEmail,
            secondaryEmail : "",
            userName : this.userName,
            password : this.password,
            address : ""
            })
            .then(
              (result) => {
                getAllUserRegistrations()
                    .then((result) => {
                        console.log('result 000 ---->', result)
                        this.tableData = result;
                    })
                    .catch((error) => {
                        console.log('Error --->', JSON.stringify(error))
                        this.deletedRecords = error.body.message;
                    }); 
            }
            
            )
            .catch(
                (error) => {
                this.error = error;
                //this.contacts = undefined;
                console.log('error --->', error)
                this.errorMessage = error.body.message;
            }
            ).finally ({

            });

        console.log('firstName --->', this.firstName);
        console.log('lastName --->', this.lastName);
    }
    
    handleDelete(event) {
        var selectedRecords =  this.template.querySelector("lightning-datatable").getSelectedRows();
        if(selectedRecords.length > 0){
            console.log('selectedRecords ====> ' +JSON.stringify(selectedRecords));
        }
        let toBeDeletedRecordIds = [];
        selectedRecords.forEach(currentRecord => {
              //ids = ids + ',' + currentRecord.Id;
              console.log('current record--->'+currentRecord.Id)
              toBeDeletedRecordIds.push(currentRecord.Id)
        });

        deleteUserRegistrations({ 
            userRegistrationIds : toBeDeletedRecordIds
            })
            .then(() => {
                console.log('result ---->', result)
                refreshApex(this.tableData)
                
            })
            .catch((error) => {
                console.log('Error --->', JSON.stringify(error))
                this.deletedRecords = error.body.message;
            });  
           
    }
    

    handleCancel(event) {
        this.clickedButtonLabel = event.target.label;
    }

    handleReset(event) {
        this.clickedButtonLabel = event.target.label;
    }
    
}