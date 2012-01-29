Session = App.Session

###
	Controller to login / logout an user

	Please note:
	This controller handles again Spine's core values: Asynchronous UIs
	Because logging in needs to wait of a server respond (authentication)
	to avoid rendering content without a logged in user

	To get more info about Spine's "Asynchronous UI"
	check out http://spinejs.com/docs/ajax

###
class App.SessionController extends Spine.Controller

	className: 'login'

	elements:
		'form': 'form'

	events:
		'submit form': 'login'


	constructor: ->
		super

		@routes
			'/logout': ->
				@logout()

		# bind active event to @render
		@active @render

	render: ->
		@html @view('login')()


	login: (event) ->
		event.preventDefault()


		@session = Session.fromForm(@form)
		# bind ajax events of Session,
		# because in this case we don't use Spines (build-in) asynchronous UI concept
		@session.bind "ajaxSuccess", @loginResultHandler
		@session.bind "ajaxError", @loginErrorHandler
		@session.save()


	logout: ->
		# clear session data
		@session.destroy()
		delete @session
		# navigate back to '/login'
		@navigate '/login'


	loginResultHandler: (status, xhr) =>
		@session.unbind()
		@session.authorized = xhr.authorized

		if @session.authorized is "true"
			@navigate '/employees'
		else
			alert "Invalid username or password!"


	loginErrorHandler: (record, xhr, settings, error) =>
		@session.unbind() if @session?
		alert "Error: " + error