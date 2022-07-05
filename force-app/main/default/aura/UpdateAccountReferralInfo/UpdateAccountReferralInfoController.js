({
    /**
     * Initialize quick action. This action validates action is active and current user
     * is not an international user. Upon validation, the action populates the referral information
     * on the account record.
     */
    init: function(component, event, helper) {
       helper.updateReferral(component, event, helper);
       
       //helper.refreshView(component, event, helper);
    }
});