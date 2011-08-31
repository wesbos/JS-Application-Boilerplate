### 
Application
###
App = {}

# stores array of queued ajax requests
App.queue = []

# stores array of cached objects, primarily DOM selectors
App.cache = {}

# subscriptions
App.subscriptions = {}

# pubsub
App.publish = (topic,args) ->
	App.subscriptions[topic] and $.each App.subscriptions[topic], ->
		this.apply(App, args or [])
		return
	return

App.subscribe = (topic, callback) ->
	App.subscriptions[topic] = [] unless App.subscriptions[topic]
	App.subscriptions[topic].push(callback)
	[topic, callback]

App.unsubscribe = (handle) ->
	t = handle[0]
	App.subscriptions[t] and $.each App.subscriptions[t], (idx) ->
	if this is handle[1]
		App.subscriptions[t].splice(idx,1)
	return
	
###
	Subscriptions
###
App.subscribe "init", ->
	# go nuts

###
	Events
###
	
# DOM Ready
jQuery ($) ->
	App.publish "init"
	return

# Window unload
jQuery(window).unload ->
	App.publish "destroy"
	return

