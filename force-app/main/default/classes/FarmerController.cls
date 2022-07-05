public class FarmerController{
    //Instance/object varibales
   private String privatefarmerName='Madhu';
   public String publicfarmerName='Mallesh';
   public String publicfarmerName1;
   public Integer age; //9,20
   public Decimal amount; //100.00,200.00,10.50
   public Date dob; // date month year
   public Datetime dobtime; // date month year time
   
   // Static/class level variables
   private static String stprivatefarmerName='Madhu Static';
   public static String stpublicfarmerName='Mallesh Static';
   
   //instance methods
   public string privateMethod(Integer age){
   
       return 'test1';
   }
   public string privateMethod(String name){
       //method body
       Integer myAge;
       if(name == 'John'){
           System.debug(name);
       }else{
           System.debug(name);
       }
       
       return 'test';
   }
   
   public void publicmethod(){
       
   }
   //Static methods

}