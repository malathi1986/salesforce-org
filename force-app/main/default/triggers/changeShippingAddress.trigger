trigger changeShippingAddress on Account (before insert){
    for(Account aObj : Trigger.new){
    //We should first check whether the user is passing null data
    if(aObj.BillingStreet!=null){
    aObj.ShippingStreet=aObj.BillingStreet;
    }
    if(aObj.BillingCity!=null){
    aObj.ShippingCity=aObj.BillingCity;
    }
    if(aObj.BillingState!=null){
    aObj.ShippingState=aObj.BillingState;
    }
    if(aObj.BillingPostalCode!=null){
    aObj.ShippingPostalCode=aObj.BillingPostalCode;
    }
    if(aObj.BillingCountry!=null){
    aObj.ShippingCountry=aObj.BillingCountry;
    }
    }
    }