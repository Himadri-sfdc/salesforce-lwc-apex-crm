
public with sharing class AccDescChangeWithConFullName {
    
    //Updating the Account Description With Contact Full Name and todays date
    
    public static Void syncingAccDescription(List<Contact> conList,Map<Id,Contact> oldMap)
    {
        Map<Id,Contact> conMap = new Map<Id,Contact>();
        List<Account> accList = new List<Account>();
        
        for(Contact con : conList)
        {
            if(oldMap != null)
            {
                Contact oldCon = oldMap.get(con.Id);
                
                if(con.FirstName != oldCon.FirstName || con.LastName != oldCon.LastName)
                {
                    conMap.put(con.AccountId,con);
                }
            }
            else 
            {
                conMap.put(con.AccountId,con);
            }
        }
        if(!conMap.isEmpty())
        {
            for(Account acc : [SELECT Id,Description FROM Account WHERE Id IN : conMap.KeySet()])
            {
                acc.Description = conMap.get(acc.Id).FirstName + ' ' + conMap.get(acc.Id).LastName + ' ' + System.Today();
                
                accList.add(acc);
            }
            
            if(!accList.isEmpty())
            {
                update accList;
            }
        }
    }
}