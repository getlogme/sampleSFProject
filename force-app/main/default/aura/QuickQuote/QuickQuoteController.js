({
	doInit : function(component, event, helper) {
		
		var step2 = component.find("step2");
		console.log("doInit"+step2.display);
        $A.util.addClass(step2, 'hide');
	},
	
	nextAction : function(component, event, helper){
		console.log("nextAction");
		var step1 = component.find("step1");
        $A.util.addClass(step1, 'hide');
        
        var step2 = component.find("step2");
        $A.util.addClass(step2, 'show');
	}
})