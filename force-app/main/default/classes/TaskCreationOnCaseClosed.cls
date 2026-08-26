public with sharing class TaskCreationOnCaseClosed {
    
     public static void TaskCreation(List<Case> caseList,Map<Id,Case> oldMap){
        
        List<Task> taskList = new List<Task>();
        
        for(Case newCase : caseList){
            
            Case oldCase = oldMap.get(newCase.Id);
            
            if(oldCASE.Status != newCase.Status && newCase.Status == 'Closed'){
                
                Task tsk = new Task();
                tsk.Subject = 'Follow-up Task on Closed Case';
                tsk.Status = 'Not Started';
                tsk.Priority = 'Normal';
                tsk.WhatId = newCase.Id;
                taskList.add(tsk);
            }
        }
        if(!taskList.isEmpty()){
            
            insert taskList;
        }
    }
}