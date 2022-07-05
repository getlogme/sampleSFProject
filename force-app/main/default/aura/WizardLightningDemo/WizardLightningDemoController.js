({
    afterLoaded : function(component, event, helper) {
        var current = 1;
         
        widget = $(".step");
        btnnext = $(".next");
        btnback = $(".back"); 
        btnsubmit = $(".submit");
         
        widget.not(':eq(0)').hide();
         
        helper.hideButtons(component,widget,current);
        helper.setProgress(component,widget,current);
         
        //Next Button Action
        btnnext.click(function(){
            if(current < widget.length){
                // Check validation
                if($(".form").valid()){
                    widget.show();
                    widget.not(':eq('+(current++)+')').hide();
                    helper.setProgress(component,widget,current);
                }
            }
            helper.hideButtons(component,widget,current);
        })
         
        //Back Button Action
        btnback.click(function(){
            if(current > 1){
                current = current - 2;
                if(current < widget.length){
                    widget.show();
                    widget.not(':eq('+(current++)+')').hide();
                    helper.setProgress(component,widget,current);
                }
            }
            helper.hideButtons(component,widget,current);
        })       
                
    },
     
    saveContact : function(component, event, helper) {
        component.set("v.newContact.bklightning__Firstname__c",$("#fname").val());
        component.set("v.newContact.bklightning__Lastname__c",$("#lname").val());
        component.set("v.newContact.bklightning__Email__c",$("#email").val());
        component.set("v.newContact.bklightning__Phone__c",$("#phone").val());
        component.set("v.newContact.bklightning__Address__c",$("textarea#address").val());
        component.set("v.newContact.bklightning__Company__c",$("#company").val());
        component.set("v.newContact.bklightning__NumberOfEmployee__c",$("#numberofemp").val());
        component.set("v.newContact.bklightning__Website__c",$("#website").val());
         
        var newContact = component.get("v.newContact");
         
        helper.upsertContact(component, newContact);    
         
        $('.showMsg').show();
        $('.form')[0].reset();
    }
     
})