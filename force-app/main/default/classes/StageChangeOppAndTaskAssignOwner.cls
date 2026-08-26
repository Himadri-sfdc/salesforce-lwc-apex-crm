public with sharing class StageChangeOppAndTaskAssignOwner {

     public static void TaskCraetionAndOppOwnerId(List<Opportunity> oppList,Map<Id,Opportunity> oldMap){
        
        List<task> TaskList = new List<Task>();
        
        for(Opportunity newOpp : oppList){
            
            if(oldMap != null){
                
                Opportunity oldOpp = oldMap.get(newOpp.Id);
                
                if(oldOpp.StageName != newOpp.StageName){
                    
                    Task tsk = new Task();
                    tsk.Subject = 'Follow Up Task in Queue';
                    tsk.Priority = 'High';
                    tsk.Status = 'Not Started';
                    tsk.WhatId = newOpp.Id;
                    tsk.OwnerId = newOpp.OwnerId;
                    TaskList.add(tsk);
                }
            }
        }
        if(!TaskList.isEmpty()){
            
            insert TaskList;
        }
    }
}