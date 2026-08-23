public with sharing class CountOpportunityLineItem {
    
      public static void CountOliInAccount(List<OpportunityLineItem> oliList){
        
        Set<Id> OppIds = new Set<Id>();
        Set<Id> accIds = new Set<Id>();
        Map<Id,Integer> accCountMap = new Map<Id,Integer>();
        List<Account> accToUpdate = new List<Account>();
        
        for(OpportunityLineItem oliNew : oliList){
            
            OppIds.add(oliNew.OpportunityId);
        }
        
        if(!OppIds.isEmpty()){
            
            for(Opportunity opp : [SELECT Id,AccountId FROM Opportunity WHERE Id IN : OppIds]){
                
                accIds.add(opp.AccountId);
            }
        }
        if(!accIds.isEmpty()){
            
            for(AggregateResult aggr : [SELECT Opportunity.AccountId accId, Count(Id) cnt FROM OpportunityLineItem WHERE Opportunity.AccountId 
                                       IN : accIds GROUP BY Opportunity.AccountId])
            {
                accCountMap.put((Id)aggr.get('accId'),(Integer)aggr.get('cnt'));
            }
        }
        for(Account acc : [SELECT Id,NumberOfLineItem__c FROM Account WHERE Id IN : accIds]){
            
            acc.NumberOfLineItem__c = accCountMap.containsKey(acc.Id) ? accCountMap.get(acc.Id) : 0;
            
            accToUpdate.add(acc);
        }
        if(!accToUpdate.isEmpty()){
            
            update accToUpdate;
        }
    }
}

trigger TriggerHandlerOppLineItem on OpportunityLineItem (after insert,after delete) {

    if(trigger.isAfter){
        
        if(trigger.isInsert){
            
            CountOpportunityLineItem.CountOliInAccount(trigger.new);
            
        } else if(trigger.isDelete){
            
              CountOpportunityLineItem.CountOliInAccount(trigger.old);
        }
    }

}