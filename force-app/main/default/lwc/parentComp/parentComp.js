import { LightningElement,track } from 'lwc';

export default class ParentComp extends LightningElement {
    @track msg;
    handleChangeEvent(event){
        this.template.querySelector('c-child-Comp').changeMessageFromParent(event.target.value);
    }
   //Method to handle the custom event dispatched by the child component
    handleCustomEvent(event) {
        const textVal = event.detail;
        this.msg = textVal;
    }
}