### 
	Application
	
	Initial Code by Darcy Clarke
	Converted to CoffeeScript by Wes Bos
	
	Do what you want License! 
	
###
App = {}

# stores array of queued ajax requests
App.queue = []

# Store the URL of your application 

App.url = ""

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

# Based on https://www.paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
# Converted to coffeescript by Wes Bos - http://wesbos.com
window.log = ->
	log.history = log.history or []
	log.history.push arguments
	console.log( Array.prototype.slice.call(arguments) ) if @console
	return
