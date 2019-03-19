({
	outputPicklist: function(component, event, helper) {
        var action = component.get("c.OutputPicklist");
        action.setCallback(this, function(response) {
        	component.set("v.SensorsPicklist", response.getReturnValue());
        });
        $A.enqueueAction(action);
   	},
    viewName: function(component, event, helper) { 
        var actionName = component.get("c.ViewName");
    	var recordName = component.find("selectid").get("v.value");
        
      	actionName.setParams({
        	"recordName": recordName
      	});
        
        actionName.setCallback(this, function(response) {
        	var state = response.getState();
          	if (state === "SUCCESS")  {
            	component.set('v.Sensor', response.getReturnValue()); 
                //component.set("v.isOpen", true);
			}
          	else {alert('Error');}
      	});
      	$A.enqueueAction(actionName);
	},
    
	viewRecords: function(component, event, helper) { 
      	var actionEvents = component.get("c.ViewEvents");
    	var recordName = component.find("selectid").get("v.value");
        
        actionEvents.setParams({
        	"recordName": recordName
      	});
        
      	actionEvents.setCallback(this, function(response) {
        	var state = response.getState();
          	if (state === "SUCCESS")  {
            	component.set('v.SensorEvents', response.getReturnValue());   
            	component.set("v.isOpen", true);
			}
          	else {alert('Error');}
      	});
      	$A.enqueueAction(actionEvents);
        var a = component.get('c.viewName');
        $A.enqueueAction(a);
	},
    
	updateSensor: function(component, event, helper) { 
        var validationEvents = component.get("v.SensorEvents");
        var flag = false;
        for(var i = 0;i<validationEvents.length;i++) {
            if(validationEvents[i].x__c == "" || validationEvents[i].y__c == "" || validationEvents[i].z__c == "")
				flag = true;
        }
        if(flag)
            alert("ERROR: Please check out coordinate fields");
		else {
        	var action = component.get("c.UpdateEvents");
            var JSONstring = JSON.stringify(component.get("v.SensorEvents")).replace(/_/g,"");
           	var recordName = component.find("selectid").get("v.value");
            console.log(JSONstring);
            action.setParams({
                "recordName": recordName,
                "JSONstring": JSONstring
            });
            
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS")  {
                    alert('Update successful');
                }
                else {console.log('UPDATE_ERROR');}
            });
            $A.enqueueAction(action);
            
            var a = component.get('c.viewRecords');
            $A.enqueueAction(a);
		}
	}
})