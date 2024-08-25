import { LightningElement, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import {
    subscribe,
    unsubscribe,
    APPLICATION_SCOPE,
    MessageContext,
  } from "lightning/messageService";
  import contactMessageChannel from "@salesforce/messageChannel/contactMessageChannel__c";
  import NAME_FIELD from "@salesforce/schema/Contact.Name";
  import TITLE_FIELD from "@salesforce/schema/Contact.Title";
  import PHONE_FIELD from "@salesforce/schema/Contact.Phone";
  const fields = [NAME_FIELD, TITLE_FIELD, PHONE_FIELD];
export default class LmsSubscriberWebComponent extends LightningElement {}