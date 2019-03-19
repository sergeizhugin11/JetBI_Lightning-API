({
	outputProjectStatistics : function(component, event, helper) {
		
		helper.makeCalloutToGetProjectStatistics(component);
	},
	Sort: function(component, event, helper) {
			var buttonstate = component.get('v.buttonstate');
			component.set('v.buttonstate', !buttonstate);
			component.set('v.commitsInf', '');
			var s = component.get('v.commitsSort');
			s.reverse();
			component.set('v.commitsInf', s);
   	}
})