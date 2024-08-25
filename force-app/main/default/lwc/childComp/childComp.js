import { LightningElement,track,api } from 'lwc';

export default class childComp extends LightningElement {
    @track Message;
    @api
    changeMessageFromParent(String){
        this.Message=String.toUpperCase();

    }
    handleChange(event) {
        event.preventDefault();
        const name = event.target.value;
        const selectEvent = new CustomEvent('mycustomevent', {
            detail: name
        });
       this.dispatchEvent(selectEvent);
    }
}