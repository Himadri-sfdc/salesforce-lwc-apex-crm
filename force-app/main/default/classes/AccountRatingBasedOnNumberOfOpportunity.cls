public with sharing class AccountRatingBasedOnNumberOfOpportunity {
 
     public static void BasedOnRating(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
        
        Set<Id> accId = new Set<Id>();
        Map<Id,Integer> currentOpp = new Map<Id,Integer>();
        List<Account> accList = new List<Account>();
        
        for(Opportunity newOpp : oppList){
            
                if(oldMap != null) {

                Opportunity oldOpp = oldMap.get(newOpp.Id);

                if(newOpp.AccountId != null)
                    accId.add(newOpp.AccountId);

                if(oldOpp.AccountId != null)
                    accId.add(oldOpp.AccountId);

            } else {

                if(newOpp.AccountId != null)
                    accId.add(newOpp.AccountId);
            }
        }
        if(!accId.isEmpty()){
            
            for(AggregateResult aggr : [SELECT AccountId accId,Count(Id) cnt FROM Opportunity WHERE AccountId IN : accId
                                       GROUP BY AccountId])
            {
                currentOpp.put((Id)aggr.get('accId'),(Integer)aggr.get('cnt'));
            }
        }
        
        for(Account acc : [SELECT Id,Rating FROM Account WHERE Id IN : accId]){
            
            Integer c = currentOpp.containsKey(acc.Id) ? currentOpp.get(acc.Id) : 0;
            
            if(c > 3){
                
                acc.Rating = 'Hot';
                
            } else if(c >= 2 && c <= 3 ){
                
                acc.Rating = 'Warm';
                
            } else {
                
                acc.Rating = 'Cold';
            }
            
            accList.add(acc);
        }
        
        if(!accList.isEmpty()){
            
            update accList;
        }
    }
}