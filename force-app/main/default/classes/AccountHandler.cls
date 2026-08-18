
public with sharing class AccountHandler {

    @AuraEnabled(cacaheable = true)
    public static List<Account> getAccDetails(String searchKey)
}