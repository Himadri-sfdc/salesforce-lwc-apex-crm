public with sharing class CreateTaskWhenOppIsClosedWon {
    public static void createTaskOnClosedWon(List<Opportunity> oppList,Map<Id,Opportunity> oldMap)
    {
       List<Task> tList = new List<Task>();

        for (Opportunity opp : oppList) {

            // Prevent null issue in insert
            if (oldMap != null &&
                opp.StageName != oldMap.get(opp.Id).StageName &&
                opp.StageName == 'Closed Won') {

                Task t = new Task();
                t.WhatId = opp.Id;
                t.Subject = 'Email';
                t.Priority = 'Normal';
                t.Status = 'Not Started';
                t.OwnerId = UserInfo.getUserId();

                tList.add(t);
            }
        }

        if (!tList.isEmpty()) {
            insert tList;
        }
    }
}