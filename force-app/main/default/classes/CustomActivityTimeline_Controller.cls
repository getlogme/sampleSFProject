public with sharing class CustomActivityTimeline_Controller {
    public CustomActivityTimeline_Controller() {

    }
    @AuraEnabled(Cacheable=true)
    public static map<String, List<SObject>> fetchActivities(string recId) {
        integer openActivitesCount = 0;
        integer pastActivitesCount = 0;
        map<String, List<SObject>> activityMap = new map<String, List<SObject>>();
        try{
            Account acc=  [SELECT id,
                           (SELECT Owner.Name, ActivityDate, ActivityDateTime, Status, istask, ActivitySubtype, Subject, OwnerId, StartDateTime, EndDateTime, Description, WhatId, CreatedDate, CreatedById FROM OpenActivities),
                           (SELECT Owner.Name,ActivityDate, ActivityDateTime, Status, istask, ActivitySubtype, Subject, OwnerId, StartDateTime, EndDateTime, Description, WhatId, CreatedDate, CreatedById FROM ActivityHistories)
                           FROM Account Where id = :recId LIMIT 1];
            
            activityMap.put('Next Activities', acc.OpenActivities);
            openActivitesCount+=acc.OpenActivities.size();
            activityMap.put('Past Activities', acc.ActivityHistories);
            pastActivitesCount+=acc.ActivityHistories.size();
            
                      
            Integer activityLimit = 100;
            List<SObject> activityList = activityMap.get('Past Activities');
            CustomActivityTimeline_Controller.CustomActivity CustomActivityVar = new CustomActivityTimeline_Controller.CustomActivity();
            List<CustomActivityTimeline_Controller.CustomActivity> CustomActivityList = CustomActivityVar.FetchCustomActivity(activityList,'Past');
            List<SObject> sortedPastActivity = new List<Sobject>();
            CustomActivityList.sort();
            
            for(Integer i = CustomActivityList.size() - 1; i >= 0 && sortedPastActivity.size() <= activityLimit ; i--){
                sortedPastActivity.add(CustomActivityList[i].activity);
            }
            
            activityMap.put('Past Activities',sortedPastActivity);
            
            activityList = activityMap.get('Next Activities');
            CustomActivityList = CustomActivityVar.FetchCustomActivity(activityList,'Next');
            List<SObject> sortedNextActivity = new List<Sobject>();
            CustomActivityList.sort();
            
            for(Integer i = CustomActivityList.size() - 1; i >= 0 && sortedNextActivity.size() <= activityLimit ; i--){
                sortedNextActivity.add(CustomActivityList[i].activity);
            }
            activityMap.put('Next Activities',sortedNextActivity);
        }
        catch(Exception e){
            system.Debug(logginglevel.Error,'Error message '+ e.getLineNumber());
            system.Debug(logginglevel.Error,'Error message '+ e.getStackTraceString());
            system.Debug(logginglevel.Error,'Error message '+ e.getCause());
            system.Debug(logginglevel.Error,'Error message '+ e.getMessage());
        }
        
        return activityMap;     
    }

    @AuraEnabled
    public static void completeActivity(Id activityId, Boolean isTask, Boolean isEvent) {
        List<Task> taskList;   
        List<Event> eventList;
        // Checking if Activity is a Task or an Event
        if (isTask) {
            try {
                taskList = [SELECT Id, Status FROM Task WHERE Id = :activityId];
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
        else if (isEvent) {
            try {
                eventList = [SELECT Id FROM Event WHERE Id = :activityId];
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }

        // Assigning Activity as completed
        if (isTask && taskList.size() > 0) {
            Task task = taskList[0];
            task.Status = 'Completed';
            update task;
        }
        
    }

    @AuraEnabled
    public static void saveDateChange(Id activityId, Date dueDate, Datetime startDate, Datetime endDate, Boolean isTask, Boolean isEvent) {
        if (isTask) {
            Task task = [SELECT Id, ActivityDate FROM Task WHERE Id = :activityId][0];
            task.ActivityDate = dueDate;
            update task;
        }
        else if (isEvent) {
            Event event = [SELECT Id, StartDateTime, EndDateTime FROM Event WHERE Id = :activityId][0];
            event.StartDateTime = startDate;
            event.EndDateTime = endDate;
            update event;
        }
    }
    
    public class CustomActivity implements Comparable {
        public SObject activity {get;set;}    
        public DateTime sortDate {get; set;}
        
        public CustomActivity() {
        }
        public CustomActivity(SObject activity, DateTime sortDate) {
            this.activity = activity;
            this.sortDate = sortDate;
        }
        public  List<CustomActivity> FetchCustomActivity(List<SObject> activityList,String activityType) {
            List<CustomActivity> CustomActivityList = new List<CustomActivity>();
            for(sobject Activity : activityList){
                if(activityType == 'Past'){
                    DateTime sortDate = Date.today().addYears(-10);
                    if(Activity.get('Completion_Date__c') != null){
                        sortDate = (DateTime)Activity.get('Completion_Date__c');
                    }
                    CustomActivityList.add(new CustomActivityTimeline_Controller.CustomActivity(Activity,sortDate));    
                }
                else if(activityType == 'Next'){
                    DateTime sortDate = Date.today().addYears(-10);
                    if(Activity.get('ActivityDate') != null){
                        sortDate = (DateTime)Activity.get('ActivityDate');
                    }
                    CustomActivityList.add(new CustomActivityTimeline_Controller.CustomActivity(Activity,sortDate)); 
                }
                
            }
            return CustomActivityList;            
        }
        
        public Integer compareTo(Object ObjToCompare) {
            CustomActivity that = (CustomActivity)ObjToCompare;
            if (this.sortDate > that.sortDate) return -1;
            if (this.sortDate < that.sortDate) return 1;
            return 0;
        }
    }
}