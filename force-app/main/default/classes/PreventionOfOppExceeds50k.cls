public with sharing class PreventionOfOppExceeds50k {

        public static void LimitOppAmount(List<Opportunity> oppList){
        
        Set<Id> accId = new Set<Id>();
        Map<Id,Decimal> mapToAmt = new Map<Id,Decimal>();
        Map<Id,Decimal> mapToNewAmt = new Map<Id,Decimal>();
        
        for(Opportunity opp : oppList){
            
            if(opp.AccountId != null){
                
                accId.add(opp.AccountId);
            }
        }
        if(!accId.isEmpty()){
            
            for(AggregateResult aggr : [SELECT AccountId accId,Sum(Amount) sumAmt FROM Opportunity WHERE AccountId IN : accId
                                        AND CreatedDate = TODAY GROUP BY AccountId ])
            {
                mapToAmt.put((Id)aggr.get('accId'),(Decimal)aggr.get('sumAmt'));
            }
        }
        for(Opportunity opp : oppList){
            
            if(opp.AccountId == null) continue;
            
            Decimal amtExisting = mapToAmt.containsKey(opp.AccountId) ? mapToAmt.get(opp.AccountId) : 0;
            Decimal amtRunning = mapToNewAmt.containsKey(opp.AccountId) ? mapToNewAmt.get(opp.AccountId) : 0;
            Decimal currentAmt = opp.Amount == null ? 0 : opp.Amount;
            
            if((amtExisting + amtRunning + currentAmt) > 50000){
                
                opp.addError('Limit Exceeds to 50k');
            } 
            else {
                
                mapToNewAmt.put(opp.AccountId,amtRunning+currentAmt);
            }
            
        }
    }

}
