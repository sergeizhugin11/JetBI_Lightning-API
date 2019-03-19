({
	CallbackMethod : function(component) {
		var action = component.get("c.makeCalloutToGetStatistics");
		var project = component.get("v.project");
      	action.setParams({
        	"project": project
      	});
        
        action.setCallback(this, function(response) { 
			var state = response.getState();
          	if (state === "SUCCESS")  {
			console.log(response.getReturnValue());
            	component.set('v.project', response.getReturnValue()); 
			}
          	else {alert('Error');}
        });
        $A.enqueueAction(action);
	}
})