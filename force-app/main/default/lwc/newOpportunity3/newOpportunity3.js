import { LightningElement,track,wire} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import validateForm from '@salesforce/apex/OpporunityUtility.validateForm';
import { encodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import getRecordTypes from '@salesforce/apex/OpporunityUtility.getRecordTypes';


export default class NewOpportunity1 extends NavigationMixin(LightningElement) {

@track opportunityName
@track accountName
@track oppName
@track opportunityNameError;
@track opportunitySuccess;
@track accountNameError;
@track accountSuccess;
@track accountRecId;
@track options=[];
@track selectedRecordType='';
record;
error=undefined;

value = '';

@wire(getRecordTypes)
processRecordTypes({ error, data }) {
    if (data) {
        this.options = data.map(record => ({ label: record.Name, value: record.Name }))
        
        console.log('Malathi from Sindathipettai ' +  JSON.stringify(data));
        console.log('Malathi from Sindathipettai 2' +  JSON.stringify(this.options));
        
    } 
    else if (error) {
        this.error = error;
    }
}   



/*@wire(getRecordTypes)
processRecordTypes({ error, data }) {
    if (data) {
        for (let i = 0; i < data.length; i++) {
            console.log('Malathi from Sindathipettai ' + i);
            this.options.push({label: data[i].Name, value: data[i].Name});
        }
        console.log('Malathi from Sindathipettai ' +  JSON.stringify(data));
        console.log('Malathi from Sindathipettai 2' +  JSON.stringify(this.options));
        //
    } 
    else if (error) {
        this.error = error;
    }
}*/

/*connectedCallback(){
    getRecordTypes()
    .then((data) => {
        console.log("Json output "+JSON.stringify(data));
        for (let i = 0; i < data.length; i++) {
            console.log('Malathi from Sindathipettai ' + i);
            this.options.push({label: data[i].Name, value: data[i].Id});
        }
        console.log('Malathi from Sindathipettai ' +  JSON.stringify(data));
        console.log('Malathi from Sindathipettai 2' +  JSON.stringify(this.options));
    })    
}
*/
handleopportunityNameChange(){
  
    let oppNameField=this.template.querySelector(".oppnameCls");
if (oppNameField.name==="opportunityName"){
    console.log('Validate opportunityName-----> 1  ',oppNameField.value);

    this.oppName=oppNameField.value;

console.log('Validate opportunityName----->  ',this.oppName);

   }
}
   


handleChange(event) {
    //console.log('selectedRecordType  ',+this.selectedRecordType);
    this.value = event.detail.value;
}


navigateToNewContactWithDefaults() {
    const defaultValues = encodeDefaultFieldValues({
        Name: this.opportunityName,
        AccountId: this.accountRecId
    });

    console.log(defaultValues);

    this[NavigationMixin.Navigate]({
        type: 'standard__objectPage',
        attributes: {
            objectApiName: 'Opportunity',
            actionName: 'new'
        },
        state: {
            defaultFieldValues: defaultValues
        }
    });
}


validateOpportunityName(){

let inp=this.template.querySelectorAll("lightning-input");
inp.forEach(function(element){
    if(element.name === "opportunityName")
        this.opportunityName=element.value;
    else if(element.name === "account")
        this.accountName=element.value;
},this);
console.log('this.opportunityName '+this.opportunityName);
console.log('this.accountName'+this.accountName);



    validateForm({
            opportunityName : this.opportunityName,
            accountName : this.accountName
        })
        .then((result) => {
            console.log("Json output "+JSON.stringify(result));

            if(result.opportunityMsg === 'Opportunity name already exists'){
                this.opportunityNameError = 'Opportunity name already exists';
                this.opportunitySuccess = '';
                //this.accountSuccess = '';
            }  if(result.newopportunityMsg==='New opportunity is created'){
                //this.opportunitySuccess = 'Successfully Opportunity created';
                this.opportunityNameError = '';
                this.accountNameError = '';
                this.navigateToNewContactWithDefaults();

            }     

             if(result.NoAccountMsg === 'Account does not exist'){
                this.accountNameError = 'Account does not exist';
            }  
            if (result.NoAccountMsg === ''){
                console.log('Account found....')
                this.accountRecId=result.AccountId;
                console.log('this.accountRecId....'+this.accountRecId)
                this.accountNameError = undefined;
            }
        })     
}



}