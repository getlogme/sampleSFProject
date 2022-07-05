public class UpdateAccountReferralInfoApex {
    
    @AuraEnabled
    public static void processUpdateReferralFields(String accountId){
     		Account accountObject;
            try {
                accountObject = [
                    SELECT Referral_Request_Count__c
                    FROM Account WHERE ID = :accountId LIMIT 1
                ];
            } catch(Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        
            try{
                if(accountObject.Referral_Request_Count__c==NULL)
                    accountObject.Referral_Request_Count__c =1;
                else
                    accountObject.Referral_Request_Count__c =accountObject.Referral_Request_Count__c+1;
               
               accountObject.Referral_Request_By__c=UserInfo.getUserId(); 
               update accountObject;
            }
            catch(Exception e){ throw new AuraHandledException(e.getMessage()); }
        
       
    }

}