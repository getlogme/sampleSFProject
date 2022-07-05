({
	init: function (cmp, event, helper) {
        console.log("Init");
        cmp.set('v.columns', [
            {label: 'Opportunity name', fieldName: 'opportunityName', type: 'text'},
            {label: 'Stage', fieldName: 'stageName', type: 'text'}
        ]);

        cmp.set('v.data', [{opportunityName:"Test1",stageName:"Open"},{opportunityName:"Test2",stageName:"Open-InP"}]);
      },
    handleClick : function(component,event,helper){
        
    	$A.get('e.force:refreshView').fire();
            
    	
	}
})