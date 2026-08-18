public with sharing class RestrictOneOpportunityPerAccount {
  
     public static void LimitOneOppOneDay(List<Opportunity> oppList){
        
        Set<Id> accId = new Set<Id>();
        Map<Id,Integer> currentMap = new Map<Id,Integer>();
        Map<Id,Integer> newOppMap = new Map<Id,Integer>();
        
        for(Opportunity newOpp : oppList){
            
            if(newOpp.AccountId != null){
                
                accId.add(newOpp.AccountId);
            }
        }
        if(!accId.isEmpty()){
            
            for(AggregateResult aggr : [SELECT AccountId accId,Count(Id) cnt FROM Opportunity WHERE AccountId IN : accId
                                       AND CreatedDate = TODAY GROUP BY AccountId])
            {
                currentMap.put((Id)aggr.get('accId'),(Integer)aggr.get('cnt'));
            }
        }
        for(Opportunity newOpp : oppList){
            
            if(newOpp.AccountId == null) continue;
            Integer a = currentMap.containsKey(newOpp.AccountId) ? currentMap.get(newOpp.AccountId) : 0;
            Integer b = newOppMap.containsKey(newOpp.AccountId) ? newOppMap.get(newOpp.AccountId) : 0;
            if(a+b >= 1){
                newOpp.addError('Limit Exceed One Opportunity Per Account');
            } else {
                newOppMap.put(newOpp.AccountId, b + 1);
            }
        }
    }
}