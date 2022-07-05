({
	doInit : function(component, event, helper) {
		
	},
     afterScriptsLoaded: function (component, event, helper) {
    component.set("v.loaded", true);
    /*setTimeout(function () {
      component.set("v.loaded", true);
    }, 250);
    */
  }
})