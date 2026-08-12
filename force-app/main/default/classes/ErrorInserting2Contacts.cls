public with sharing class ErrorInserting2Contacts {
    
  public static void LimitContacts(List<Contact> conList)
    {
        if(conList.isEmpty() || conList == null) return;
        
        Set<Id> conWithId = new Set<Id>();
        Map<Id,Integer> existingCon = new Map<Id,Integer>();
        Map<Id,Integer> contactNew = new Map<Id,Integer>();
        
        for(Contact newCon : conList){
            
            if(newCon.AccountId != null){
                
                conWithId.add(newCon.AccountId);
            }
        }
        if(!conWithId.isEmpty()){
            
            for(AggregateResult aggr : [SELECT accountId accId, Count(Id) cnt FROM Contact WHERE AccountId IN : conWithId GROUP BY AccountId])
            {
                existingCon.put((Id)aggr.get('accId'),(Integer)aggr.get('cnt'));
            }
        }
        for(Contact newCon : conList){
            
            Integer existing = existingCon.containsKey(newCon.AccountId) ? existingCon.get(newCon.AccountId) : 0;
            Integer newValues = contactNew.containsKey(newCon.AccountId) ? contactNew.get(newCon.AccountId) : 0;
            if((existing + newValues) >= 2){
                
                newCon.addError('Only 2 contact allowed per Account');
            } else {
                
                contactNew.put(newCon.AccountId,newValues+1);
            }
            
        }
    }
}
