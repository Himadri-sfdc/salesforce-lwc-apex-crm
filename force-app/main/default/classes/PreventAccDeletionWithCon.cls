public with sharing class PreventAccDeletionWithCon {
    
    public static void restrictDeletionIfContactsExist(List<Account> accList)
    {
        Set<Id> accSet = new Set<Id>();
        Set<Id> conWithAcc = new Set<Id>();
        
        for(Account acc : accList)
        {
            accSet.add(acc.Id);
        }
        
        if(!accSet.isEmpty())
        {
            for(Contact con : [SELECT AccountId FROM Contact WHERE AccountId IN : accSet])
            {
                conWithAcc.add(con.AccountId);
            }
        }
        for(Account acc : accList)
        {
            if(conWithAcc.contains(acc.Id))
            {
                acc.addError('Account With Contact Cannot be deleted');
            }
        }
    }
}