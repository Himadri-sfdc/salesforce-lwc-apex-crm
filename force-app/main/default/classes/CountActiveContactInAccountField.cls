public with sharing class CountActiveContactInAccountField {

     public static void RollUpSummaryCountContact(List<Contact> conList,Map<Id,Contact> oldMap){
        
        Set<Id> setCon = new Set<Id>();
        Map<Id,Account> mapAcc = new Map<Id,Account>();
        
        for(Contact newCon : conList){
            
            if(oldMap != null){
                
                Contact oldCon = oldMap.get(newCon.Id);
                
                if(newCon.AccountId != oldCon.AccountId){
                    
                     if(newCon.AccountId != null)   setCon.add(newCon.AccountId);
                     if(oldCon.AccountId != null)   setCon.add(oldCon.AccountId);
                }
                else 
                {
                    if(newCon.AccountId != null) setCon.add(newCon.AccountId);
                }
            } 
            else 
            {
                if(newCon.AccountId != null) setCon.add(newCon.AccountId);
            }
        }
        if(!setCon.isEmpty()){
            
            for(AggregateResult aggr : [SELECT AccountId accId,Count(Id) cnt FROM Contact WHERE AccountId in : setCon
                                        AND isActive__c = TRUE GROUP BY AccountId])
            {
                Account acc = new Account();
                acc.Id = (Id)aggr.get('accId');
                //acc.No_of_Contact__c = (Integer)aggr.get('cnt');
                acc.Count_Active_Contact__c = (Integer)aggr.get('cnt');
                mapAcc.put(acc.Id,acc);
            }
            
            for(Id accId : setCon){
                
                if(!mapAcc.containsKey(accId)){
                    
                    Account acc = new Account();
                    acc.Id = accId;
                    //acc.No_of_Contact__c = 0;
                    acc.Count_Active_Contact__c = 0;
                    mapAcc.put(acc.Id,acc);
                }
            }
        }
        if(!mapAcc.isEmpty()){
            
            update mapAcc.values();
        }
    }
}