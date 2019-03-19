({
	CallbackMethod : function(component) {
		var action = component.get("c.makeCalloutToGetProjectInfo");
		var self = this;
        action.setCallback(this, function(response) { 
			var state = response.getState();
          	if (state === "SUCCESS")  {
            	component.set('v.projectList', response.getReturnValue()); 
				component.set('v.tempProjectList', response.getReturnValue());
				self.createTableRow(component);
			}
          	else {alert('Error');}
        });
        $A.enqueueAction(action);
	},
	CallbackMethod2 : function(component) {
		var self = this;
        var reverseProjects = component.get('v.projectList');
		reverseProjects.reverse();
		component.set('v.tempProjectList', reverseProjects);
		self.createTableRow(component);
	},
	createTableRow : function(component) {
		var self = this;
		var projectIds = component.get("v.tempProjectList");
		console.log(projectIds);	

		if(projectIds.length != 0) {
			
			$A.createComponent(
				"c:GitLabStatisticsOutput",
				{
					"project": projectIds.pop()
				},
				function(newButton, status, errorMessage){
					if (status === "SUCCESS") {
						var body = component.get("v.body");
						body.push(newButton);
						component.set("v.body", body);
						setTimeout(function(){
							self.createTableRow(component);
						},100);
					}
					else if (status === "INCOMPLETE") {
						console.log("No response from server or client is offline.")
					}
					else if (status === "ERROR") {
						console.log("Error: " + errorMessage);
					}
				}
			);
		}
    }
})