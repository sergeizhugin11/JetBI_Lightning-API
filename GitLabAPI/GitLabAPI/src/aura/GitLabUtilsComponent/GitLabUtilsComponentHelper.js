({
	CallbackMethod : function(component) {
		var action = component.get("c.makeCalloutToCreateProject");
		var projectName = String(component.get("v.ProjectName"));
		action.setParams({
                    "folderName" : projectName
        });
        action.setCallback(this, function(response) { 
			var state = response.getState();
            var responseStr = response.getReturnValue();
			if (state === "SUCCESS" && responseStr === "SUCCESS")  {
				alert('Create complite successful');
			}
			else {
				alert('ERROR: '+responseStr.slice(responseStr.indexOf('["')+2, responseStr.indexOf('"]')));
			}
        });
        $A.enqueueAction(action);
	}
})