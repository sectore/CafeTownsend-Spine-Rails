$ = jQuery.sub()

HeaderController = App.HeaderController
SessionController = App.SessionController
EmployeesController = App.EmployeesController

###
	MainController of the app
	It instantiates all needed Controller for the main-view
	and handles the "main" routes to show or hides views
###
class App.MainController extends Spine.Controller

	className: 'main-view'

	constructor: ->
		super


		mainViewStack = new MainViewStack()
		header = new HeaderController()
		footer = @view('footer')()

		###
			defining routes
		###
		@routes
			'/login': ->
				# change height of MainViewStack's @elem
				$('div .main-view-content').height(400)
				mainViewStack.login.active()
				header.deactivate()
			'/employees': ->
				# change height of MainViewStack's @elem
				$('div .main-view-content').height(530)
				mainViewStack.employees.active()
				header.activate()

		@append header, mainViewStack, footer


###
	MainViewStack for handling login- and employees view
	Note: All subviews for employees will be handled within EmployeesController
###
class MainViewStack extends Spine.Stack

	className: 'main-view-content stack'

	controllers:
		employees: EmployeesController
		login: SessionController

	default: 'login'