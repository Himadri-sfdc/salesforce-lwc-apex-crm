public with sharing class PreventDuplicateEmail {
    
    public static void restrictDuplicateEmail(List<Contact> conList,Map<Id,Contact> oldMap)
    {
        Set<String> setEmail = new Set<String>();
        Map<String,Id> conMap = new Map<String,Id>();
        Set<String> seen = new Set<String>();
        
        for(Contact newCon : conList)
        {
            if(String.isNotBlank(newCon.Email) && newCon.AccountId != null)
            {
                if(oldMap != null)
                {
                    Contact oldCon = oldMap.get(newCon.Id);
                    
                    if(oldCon == NULL || newCon.Email != oldCon.Email)
                    {
                        setEmail.add(newCon.Email);
                    }
                }
                else
                {
                    setEmail.add(newCon.Email);
                }
            }
        }
        if(!setEmail.isEmpty())
        {
            for(Contact con : [SELECT AccountId,Email FROM Contact WHERE Email IN : setEmail])
            {
                conMap.put(con.Email,con.AccountId);
            }
        }
        for(Contact newCon : conList)
        {
            if(String.isNotBlank(newCon.Email) && conMap.containsKey(newCon.Email) && conMap.get(newCon.Email) != newCon.AccountId)
            {
                newCon.addError('Duplicate Email Found Cannot be inserted');
            }
            if(seen.contains(newCon.Email))
            {
                newCon.addError('Duplicate Emails are in Transaction');
            }
            seen.add(newCon.Email);
        }
    }
}