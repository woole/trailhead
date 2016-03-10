public with sharing class OpportunityTriggerHandler{


/*
  @param : List of Opportunity
  @return: void
  @descr : This method checks if the newly created/updated Opportunity is the highest
           value (opportunity Amount) Opportunity associated with its account. If the Opportuntiy is
           the highest value then make the field 'Highest Value Opp' 
           on the account record to point to this Opportunity
*/
    public static void setHighestValueOpp(List<Opportunity> oppList)
    {    
        Set<ID> setOppId = new Set<ID>();
        List<Account> listOfAcc = new List<Account>();
        Map<Id,Decimal> mapAccAmnt = new Map<Id,Decimal>();

        for(Opportunity oppty:oppList)
        {
            setOppId.add(oppty.Id);
        }
        
        for(Opportunity opp:[SELECT Id, Amount, AccountId From Opportunity where Id IN:setOppId])
        {
            Decimal opptyAmnt = opp.Amount;
            Id accId = opp.AccountId;
            
            mapAccAmnt.put(opp.AccountId,opp.Amount);
            
            for(Account acc:[SELECT Id, Highest_Value_Opp__c, Max_Opportunity_Amount__c   From Account where Id=:accId])
            {
                if(opptyAmnt>acc.Max_Opportunity_Amount__c)
                {
                    acc.Highest_Value_Opp__c = opp.Id;
                    listOfAcc.add(acc);
                }
            }
        }       
        
        if(listOfAcc.size()>0)
        {
            update listOfAcc;
        }
    }

}