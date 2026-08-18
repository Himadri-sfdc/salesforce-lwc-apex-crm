public with sharing class UpdateConNAccPriAddressFromPrimaryCon {
    
    public static void UpdateContactAndAccount(List<Contact> conList,Map<Id,Contact> oldMap)
        
    {
        Map<Id,Contact> conMap = new Map<Id,Contact>();
        List<Account> accList = new List<Account>();
        List<Contact> contactList = new List<Contact>();
        
        for(Contact newCon : conList)
        {
            if(newCon.AccountId != null && newCon.PrimaryContact__c == TRUE)
            {
                if(oldMap != null)
                {
                    Contact oldCon = oldMap.get(newCon.Id);
                    
                    if(oldCon.MailingStreet != newCon.MailingStreet || oldCon.MailingCity != newCon.MailingCity)
                    {
                        conMap.put(newCon.AccountId,newCon);
                    }
                }
            }
        }
        if(!conMap.isEmpty())
        {
            for(Account acc : [SELECT Id FROM Account WHERE Id IN : conMap.KeySet()])
                
            {
                Contact primary = conMap.get(acc.Id);
                acc.BillingStreet = primary.MailingStreet;
                acc.BillingCity = primary.MailingCity;
                accList.add(acc);
            }
            
            for(Contact con : [SELECT Id ,AccountId FROM Contact WHERE AccountId IN : conMap.KeySet() AND PrimaryContact__c = FALSE])
            {
                Contact primary = conMap.get(con.AccountId);
                con.MailingStreet = primary.MailingStreet;
                con.MailingCity = primary.MailingCity;
                contactList.add(con);
            }
            
            if(!contactList.isEmpty())
            {
                update contactList;
            }
            
            if(!accList.isEmpty())
            {
                update accList;
            }
        }
    }
}