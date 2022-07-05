({
    setProgress : function(component,widget,currstep) {
        var percent = parseFloat(100 / widget.length) * currstep;
        percent = percent.toFixed();
        $(".progress-bar").css("width",percent+"%").html(percent+"%");
    },
     
    hideButtons : function(component, widget,current) {
        var limit = parseInt(widget.length); 
 
        $(".action").hide();
 
        if(current < limit) $(".next").show();
        if(current > 1) $(".back").show();
        if (current == limit) { 
            // Show entered values
            $(".display label:not(.control-label)").each(function(){
                console.log($(this).find("label:not(.control-label)").html($("#"+$(this).data("id")).val()));    
            });
            $(".next").hide(); 
            $(".submit").show();
        }   
    },
     
    upsertContact : function(component, newContact) {
        var action = component.get("c.createContact");
        action.setParams({
          "con": newContact
        });
        action.setCallback(this, function(a) {
        });
        $A.enqueueAction(action);
    }
})