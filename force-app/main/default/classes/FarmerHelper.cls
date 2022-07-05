public class FarmerHelper{

    public void getControllerInfo(){
        FarmerController fc=new FarmerController();
        String st=fc.publicfarmerName;
        Integer age=12;
        String name='John';
        String st1=fc.privateMethod(age);
        String st2=fc.privateMethod(name);
        String st3=fc.privateMethod('mallesh');
        
        String abc=FarmerController.stpublicfarmerName;
           
    }
}