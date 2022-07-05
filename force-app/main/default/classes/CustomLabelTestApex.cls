public class CustomLabelTestApex {
   @AuraEnabled(cacheable=true)
   public static string greetingCustomLabel(){
      return Label.greeting; 
   }
}