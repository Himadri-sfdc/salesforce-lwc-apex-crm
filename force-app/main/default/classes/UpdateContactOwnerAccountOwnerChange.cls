public with sharing class UpdateContactOwnerAccountOwnerChange {
    
    public static void UpdateContactOwner(List<Account> accList,Map<Id,Account> oldMap)
    {
        Map<Id,Id> accMap = new Map<Id,Id>();
        List<Contact> conList = new List<Contact>();
        
        if(accList == null || accList.isEmpty()) return;
        
        for(Account newAcc : accList)
        {
            if(oldMap != null)
            {
                Account oldAcc = oldMap.get(newAcc.Id);
                
                if(oldAcc == null || oldAcc.OwnerId != newAcc.OwnerId)
                {
                    accMap.put(newAcc.Id,newAcc.OwnerId);
                }
            }
        }
        if(!accMap.isEmpty())
        {
            for(Contact con : [SELECT Id,AccountId,OwnerId FROM Contact WHERE AccountId IN : accMap.KeySet()])
            {
                con.OwnerId = accMap.get(con.AccountId);
                
                conList.add(con);
            }
            
            if(!conList.isEmpty())
            {
                update conList;
            }
        }
    }
}