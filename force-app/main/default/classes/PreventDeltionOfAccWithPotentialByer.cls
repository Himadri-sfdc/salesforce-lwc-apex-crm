public with sharing class PreventDeltionOfAccWithPotentialByer {
    
    public static void RestrictAccountDeletion(List<Account> accList)
    {
        Set<Id> accId = new Set<Id>();
        Set<Id> conId = new Set<Id>();
        
        for(Account acc : accList)
        {
            accId.add(acc.Id);
        }
        
        if(!accId.isEmpty())
        {
            for(Contact con : [SELECT AccountId,Potential_Byer__c FROM Contact WHERE AccountId IN : accId AND Potential_Byer__c = TRUE])
            {
                conId.add(con.AccountId);
            }
        }
        for(Account acc : accList)
        {
            if(conId.contains(acc.Id))
            {
                acc.addError('cannot delete Account, it has related contact with potential buyer');
            }
        }
    }
}