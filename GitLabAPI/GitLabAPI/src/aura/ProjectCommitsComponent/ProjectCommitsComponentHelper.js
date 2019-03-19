({
	makeCalloutToGetProjectStatistics : function(component) {
		var sPageURL = decodeURIComponent(window.location.search.substring(1));
        var sURLVariables = sPageURL.split('&');
        var sParameter;
		var sParameterName;
		var sParameterid;
        var i;
        for (i = 0; i < sURLVariables.length; i++) {
            sParameter = sURLVariables[i].split('=');
			console.log("all: " + sParameter);
			console.log("name: " + sParameter[0]);
			console.log("value: "+sParameter[1]);
            if (sParameter[0] === 'projectId') {
                sParameterid = sParameter[1];
            }
			if (sParameter[0] === 'projectName') {
                sParameterName = sParameter[1];
            }
        }
		component.set('v.progectName', sParameterName); 
		var action = component.get("c.getProjectCommits");
      	action.setParams({
        	"projectId": sParameterid
      	});
        action.setCallback(this, function(response) { 
			var state = response.getState();
          	if (state === "SUCCESS")  {
				var a =  response.getReturnValue();
            	component.set('v.commitsInf', response.getReturnValue());
				component.set('v.commitsSort', response.getReturnValue());
			}
          	else {alert('Error');}
        });
        $A.enqueueAction(action);
	}
})