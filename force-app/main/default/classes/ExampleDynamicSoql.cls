public with sharing class ExampleDynamicSoql {
    
    public static void getAccountContactMap(){
        
        Map<String, List<String>> accMap = new Map<String, List<String>>();
        
        String query = 'SELECT Name, Account.Name FROM Contact WHERE AccountId != null';
        
        for(Contact con : (List<Contact>) Database.query(query)){
            
            String accName = con.Account.Name;
            
            if(accMap.get(accName) == null){
                accMap.put(accName, new List<String>());
            }
            
            accMap.get(accName).add(con.Name);
        }
        
        System.debug(accMap);
    }
}