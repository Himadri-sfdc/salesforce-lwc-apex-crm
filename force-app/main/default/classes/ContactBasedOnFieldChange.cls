public with sharing class ContactBasedOnFieldChange {
    
    public static void ContactCreateWithFieldChange(List<Account> accList)
    {
        List<Contact> conList = new List<Contact>();
        
        for(Account acc : accList)
        {
            if(acc.NoOfContacts__c != null)
            {
                for(Integer i = 1; i <= acc.NoOfContacts__c; i++)
                {
                    Contact con = new Contact();
                    con.LastName = 'Contact No ' +i;
                    con.AccountId = acc.Id;
                    conList.add(con);
                }
            }
        }
        if(!conList.isEmpty())
        {
            insert conList;
        }
    }
    public static void ContactCreateWithFieldChange2(List<Account> newList, Map<Id, Account> oldMap)
    {
        List<Contact> conList = new List<Contact>();

        List<Contact> conDeleteList = new List<Contact>();
        
        for(Account acc : newList)
        {
            Account oldAcc = oldMap.get(acc.Id);
            
            // CREATE - if number increased
            if(acc.NoOfContacts__c > oldAcc.NoOfContacts__c)
            {
                for(Integer i = (Integer)oldAcc.NoOfContacts__c + 1; i <= (Integer)acc.NoOfContacts__c; i++)
                {
                    Contact con = new Contact();
                    con.LastName = 'Contact No ' + i;
                    con.AccountId = acc.Id;
                    conList.add(con);
                }
            }
            
            // DELETE - if number decreased
            if(acc.NoOfContacts__c < oldAcc.NoOfContacts__c)
            {
                conDeleteList = [SELECT Id FROM Contact WHERE AccountId = :acc.Id 
                                 ORDER BY CreatedDate DESC 
                                 LIMIT :(Integer)(oldAcc.NoOfContacts__c - acc.NoOfContacts__c)];
            }
        }
        
        if(!conList.isEmpty())
        {
            insert conList;
        }
        if(!conDeleteList.isEmpty())
        {
            delete conDeleteList;
        }
    }
    
}
