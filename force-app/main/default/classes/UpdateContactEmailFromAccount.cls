public with sharing class UpdateContactEmailFromAccount {
    
    public static void UpdateEmailContact(List<Account> accList, Map<Id, Account> oldMap) {
        
        Map<Id, String> accMap = new Map<Id, String>();
        List<Contact> conList = new List<Contact>();
        
        for (Account newAcc : accList) {
            Account oldAcc = null;
            
            if (oldMap != null) {
                oldAcc = oldMap.get(newAcc.Id);
            }
            
            if (String.isNotBlank(newAcc.Email__c) &&
            (oldMap == null || oldAcc == null || oldAcc.Email__c != newAcc.Email__c)) {
                
                accMap.put(newAcc.Id, newAcc.Email__c);
            }
        }
        
        if (!accMap.isEmpty()) {
            for (Contact con : [SELECT AccountId, Email FROM Contact
                                 WHERE AccountId IN :accMap.keySet()]) {
                con.Email = accMap.get(con.AccountId);
                conList.add(con);
            }
            
            if (!conList.isEmpty()) {
                update conList;
            }
        }
    }
}