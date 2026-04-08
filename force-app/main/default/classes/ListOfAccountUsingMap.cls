public with sharing class ListOfAccountUsingMap {
    
    public static void DisplayAccountNames()
    {
        Map<Id,Account> accMap = new Map<Id,Account>();
        
        List<Account> accList = [SELECT Id, Name FROM Account];
        
        for(Account acc : accList)
        {
            accMap.put(acc.Id,acc);
        }
        
        System.debug(accMap);
    }
}