public with sharing class AccountWithSecondMaximumAmount {
    
    public static void getSecondMaximum()
    {
        List<Opportunity> oppList = [SELECT Id,Name,Amount From Opportunity WHERE AccountId != null 
                                    ORDER BY Amount DESC LIMIT 1 OFFSET 1];
        
        if(oppList.size()> 0)
        {
            System.debug('Second Maximum AMOUNT IS ' +oppList[0].Amount + ' Account Name is ' +oppList[0].Name);
        }
        else
        {
            System.debug('No Amount Found');
        }
    }
}