public with sharing class UpdateContactAddressFromAccAddress {
    
    public static void UpdatePrimaryAddressContact(List<Account> accList,Map<Id,Account> oldMap)
    {
        Map<Id,Account> accMap = new Map<Id,Account>();
        List<Contact> conList = new List<Contact>();
        
        for(Account newAcc : accList)
        {
            if(oldMap != null)
            {
                Account oldAcc= oldMap.get(newAcc.Id);
                
                if(oldAcc == null || oldAcc.BillingStreet != newAcc.BillingStreet
                    || oldAcc.BillingCity != newAcc.BillingCity
                    || newAcc.BillingCountry != oldAcc.BillingCountry)
                {
                    accMap.put(newAcc.Id,newAcc);
                }
            }
        }
        if(!accMap.isEmpty())
        {
            for(Contact con : [SELECT AccountId FROM Contact WHERE AccountId IN : accMap.keySet()])
            {
                Account acc = accMap.get(con.AccountId);
                
                con.MailingStreet     = acc.BillingStreet;
                con.MailingCity       = acc.BillingCity;
                con.MailingCountry    = acc.BillingCountry;
                
                conList.add(con);
            }
            
            if(!conList.isEmpty())
            {
                update conList;
            }
        }
    }
}