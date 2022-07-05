({
	doInit : function(component, event, helper) {
        console.log("Init");
        console.log("dmv reporting ids "+JSON.stringify(component.find("DMVReporting")));
        var dmvarr=component.find("DMVReporting");
        if(Array.isArray(dmvarr)){
                dmvarr.forEach(dmvComp=>{
                $A.util.removeClass(dmvComp,"slds-hide");   
            });    
         }else{
         	$A.util.removeClass(dmvarr,"slds-hide");            
         }
        
        
	}
})