({
	createAccount: function(component) {
        var createAccountEvent = $A.get("e.force:createRecord");
        createAccountEvent.setParams({
          entityApiName: "Account",
          defaultFieldValues: {
            Name: "accountName"
          }
        });
        createAccountEvent.fire();
  }
})