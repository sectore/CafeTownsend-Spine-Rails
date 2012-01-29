$ = jQuery.sub()

Session = App.Session

###
	Controller for the header view
###
class App.HeaderController extends Spine.Controller

	# overridden
	tag:
		'header'

	events:
		'click p.main-button': 'triggerLogout'  # clicking logout

	constructor: ->
		super
		@render()

	render: ->
		@html @view('header')()


	activate:()->
		# we do only have one session object after login
		# grab it and show its username
		session = Session.first()
		# greetings text
		if session?
			greetings = 'Hello ' + session.name  + "!"
		else
			greetings = ''
		# add text
		$('#greetings').text(greetings)
		# animate header to show
		$('header div').animate({top: '0'})

	deactivate:->
		# empty greetings text
		$('#greetings').text('')
		# animate header to hide
		$('header div').animate({top: '50'})

	triggerLogout: ->
		@navigate '/logout'