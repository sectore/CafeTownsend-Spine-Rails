#= require jquery
#= require spine/lib/spine
#= require spine/lib/manager
#= require spine/lib/ajax
#= require spine/lib/route
#= require spine/lib/tmpl
#= require spine/lib/list

#= require_tree ./lib
#= require_self

# models
#= require_tree ./models

#
# controllers has to be in a special order to avoid issues
#= require ./controllers/session_controller
#= require ./controllers/employees_controller
#= require ./controllers/header_controller
#= require ./controllers/main_controller

# views
#= require_tree ./views

class App extends Spine.Controller

	constructor: ->
		super

		# initialize and append controller of MainView
		main = new App.MainController
		@append main

		# setup routes
		Spine.Route.setup()
		# let's start routing to show login
		@navigate('/login')

window.App = App