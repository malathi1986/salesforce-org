public class UpdateAccountAmountUtil {
    
    public static Account addAmount(Opportunity opr, Account acc){
        if(acc!=null){
            if(opr.StageName == 'Closed Won'){
                Decimal curAmount = 0;
                if(acc.OpportunityWon__c!=null) curAmount = acc.OpportunityWon__c;
                acc.OpportunityWon__c = curAmount + opr.Amount;
            }
            else if(opr.StageName == 'Closed Lost'){
                Decimal curAmount = 0;
                if(acc.OpportunityClose__c!=null) curAmount = acc.OpportunityClose__c;
                acc.OpportunityClose__c = curAmount + opr.Amount;
            }
            else if(opr.StageName != 'Closed Lost' && opr.StageName != 'Closed Won'){
                Decimal curAmount = 0;
                if(acc.OpportunityOpen__c!=null) curAmount = acc.OpportunityOpen__c;
                acc.OpportunityOpen__c = curAmount + opr.Amount;
            }
        }    
        return acc;
    }
    public static Account manipulateOnChange(Opportunity opr, Account acc, Boolean wonAdd, Boolean openAdd,Boolean lostAdd, Boolean wonDeduct, Boolean openDeduct,Boolean lostDeduct){
        
        Decimal curOpenAmt = 0;
        Decimal curLostAmt = 0;
        Decimal curWonAmt = 0;
        
        if(acc.OpportunityWon__c!=null) curWonAmt =acc.OpportunityWon__c;
        if(acc.OpportunityClose__c!=null) curLostAmt =acc.OpportunityClose__c;
        if(acc.OpportunityOpen__c!=null) curOpenAmt =acc.OpportunityOpen__c;
        
        if(wonAdd){
            acc.OpportunityWon__c = curWonAmt + opr.Amount;
        }
        if(wonDeduct){
            acc.OpportunityWon__c = curWonAmt - opr.Amount;
        }
        if(lostAdd){
            acc.OpportunityClose__c = curLostAmt + opr.Amount;
        }
        if(lostDeduct){
            acc.OpportunityClose__c = curLostAmt - opr.Amount;
        }
        if(openAdd){
            acc.OpportunityOpen__c = curOpenAmt + opr.Amount;
        }
        if(openDeduct){
            acc.OpportunityOpen__c = curOpenAmt - opr.Amount;
        }
        return acc;
    }
    
}