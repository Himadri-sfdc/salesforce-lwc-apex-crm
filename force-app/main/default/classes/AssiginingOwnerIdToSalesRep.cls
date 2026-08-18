public with sharing class AssiginingOwnerIdToSalesRep {
    
    public static void assignSalesRep(List<Account> accList, Map<Id,Account> oldMap)
    {
        if(accList == null || accList.isEmpty()) return;
        
        Set<Id> ownerIds = new Set<Id>();
        
        for(Account acc : accList)
        {
            if(acc.OwnerId != null)
            {
                ownerIds.add(acc.OwnerId);
            }
        }
        
        Map<Id,User> userMap = new Map<Id,User>(
            [SELECT Id, Name FROM User WHERE Id IN :ownerIds]
            );
        
        for(Account acc : accList)
        {
            if(oldMap == null)
            {
                acc.salesRep__c = userMap.get(acc.OwnerId).Name;
            }
            
            else
            {
                Account oldAcc = oldMap.get(acc.Id);
                
                if(acc.OwnerId != oldAcc.OwnerId)
                {
                    acc.salesRep__c = userMap.get(acc.OwnerId).Name;
                }
            }
        }
    }
}