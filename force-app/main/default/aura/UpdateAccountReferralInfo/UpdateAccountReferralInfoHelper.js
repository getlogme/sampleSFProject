({
	
    updateReferral: function(component, event, helper) {
        let recordId = component.get('v.recordId');
        let action = component.get('c.processUpdateReferralFields');
     action.setParams({
                "accountId" : recordId 
            });
            action.setCallback(this, function(a){
                var state = a.getState(); // get the response state
                console.log("State"+state);
                if(state=='SUCCESS'){
                	this.refreshView(component,event,helper);    
                }
            });
            $A.enqueueAction(action);
    },

    
    refreshView: function(component,event,helper) {  
        // Reloads the data for the view
        var navEvt = $A.get("e.force:refreshView");
		let recordId = component.get('v.recordId');
    	navEvt.setParams({        
      	    "recordId": recordId
        });
        navEvt.fire();       
     
    }   
})