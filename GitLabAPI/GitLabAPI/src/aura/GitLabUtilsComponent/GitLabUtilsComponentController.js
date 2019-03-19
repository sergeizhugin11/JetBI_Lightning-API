({
	createProject: function(component, event, helper) {
		var validity = component.find("projectName").get("v.validity");
        if(!validity.valid){
            alert('Input project name!');
        }
        else {
			helper.CallbackMethod(component);
        }
   	}
})