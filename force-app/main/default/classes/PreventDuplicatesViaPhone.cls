public with sharing class PreventDuplicatesViaPhone{
    
    public static void PreventDuplicatePhone(List<Contact> conList,Map<Id,Contact> oldMap)
    {
        Set<String> setPhone = new Set<String>();
        Map<String,Id> conWithPhone = new Map<String,Id>();
        Set<String> seen = new Set<String>();
        
        for(Contact newCon : conList)
        {
            if(String.isNotBlank(newCon.Phone) && newCon.AccountId != null)
            {
                if(oldMap != null)
                {
                    Contact oldCon = oldMap.get(newCon.Id);
                    
                    if(oldCon == null || newCon.Phone != oldCon.Phone)
                    {
                        setPhone.add(newCon.Phone);
                    }
                }
                else
                {
                    setPhone.add(newCon.Phone);
                }
            }
        }
        if(!setPhone.isEmpty())
        {
            for(Contact con : [SELECT Id,Phone FROM Contact WHERE Phone IN : setPhone])
            {
                conWithPhone.put(con.Phone,con.Id);
            }
        }
        for(Contact newCon : conList)
        {
            if(String.isNotBlank(newCon.Phone) && conWithPhone.containsKey(newCon.Phone) && conWithPhone.get(newCon.Phone) != newCon.Id)
            {
                newCon.addError('Duplicate Phone Number Found');
            }
            if(seen.contains(newCon.Phone))
            {
                newCon.addError('Duplicate Phone in Transaction');
            }
            seen.add(newCon.Phone);
        }
    }
}