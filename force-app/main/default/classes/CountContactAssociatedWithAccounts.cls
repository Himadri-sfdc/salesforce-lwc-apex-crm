public with sharing class CountContactAssociatedWithAccounts {
    
    public static void CounAccontContacts() {
        
        List<AggregateResult> result = [SELECT AccountId accId, Count(Id) cnt 
                                        FROM Contact
                                        WHERE AccountId != null
                                        GROUP BY AccountId];
        
        for(AggregateResult aggr : result)
        {
            Id accId = (Id)aggr.get('accId');
            Integer cnt = (Integer)aggr.get('cnt');
            
            System.debug(accId + ' With Number Of Contacts ' + cnt);
            
        }
    }
}