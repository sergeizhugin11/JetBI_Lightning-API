({
	outputId: function(component, event, helper) {
			helper.CallbackMethod(component);
   	},
	Sort: function(component, event, helper) {
			var buttonstate = component.get('v.buttonstate');
			component.set('v.buttonstate', !buttonstate);
			component.set('v.liked', !component.get('v.liked'));
			component.set('v.body', '');
			helper.CallbackMethod2(component);
   	}
})