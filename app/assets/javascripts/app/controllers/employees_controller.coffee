#List = require 'spine/lib/list'
$ = jQuery.sub()
Employee = App.Employee


###
	MainController for employees views
	It handles routes and the  view stacks of employees
	Also it handles EmployeeEvent's which are tiggered from other Controllers
###
class App.EmployeesController extends Spine.Controller

	className:
		'employees'

	constructor: ->
		super

		@employeeViewStack = new EmployeesViewStack()

		@append @employeeViewStack

		###
			routes using by employeesViewStack
		###
		@routes
			'/employees/new': (params) ->
				data = { id: params.id, add: true }
				@employeeViewStack.new.active( data )

			'/employees/:id/edit': (params) ->
				data = { id: params.id, edit: true }
				@employeeViewStack.edit.active( data )

		# handle global event using @proxy
		# to ensure executing the event handler in the correct context
		Spine.bind 'EmployeeEvent:DELETE', @proxy( @confirmDelete )


	###
		@overridden
		to ensure that the overview is active
		Because we can define one route handler for '/employee' only
		which is already in MainController defined
	###
	active:(params) ->
		super params
		@employeeViewStack.index.active()

	confirmDelete: (employee) ->
		@delete(employee) if confirm "Are you sure you want to delete #{ employee.first_name } #{ employee.last_name }?"

	delete:(employee) ->
		employee.destroy()
		@navigate '/employees'



###
	Controller to show a list of all employees.
	Selected employee can be deleted or changed.
	New employees can be added
###
class EmployeesOverview extends Spine.Controller

	className:
		'employees-index'

	elements:
		'#employee-list': 'items'

	events:
		'click #bAdd': 'add'        # clicking Add button
		'click #bEdit': 'edit'      # clicking Edit button
		'click #bDelete': 'delete'  # clicking Delete button
		'dblclick .item': 'edit'    # double clicking item of list

	constructor: ->
		super

		Employee.bind 'refresh change', @render

		@html @view('employees/index')()

		@list = new Spine.List
			el: @items,
			template: @view('employees/item')
			selectFirst: true

		@list.bind 'change', @change

		# a flag to fetch data only once
		@fetchData = true

		@active @handleActive


	change: (employeeID) =>
		@employee = Employee.find employeeID if employeeID?

	render: =>
		employees = Employee.all()
		@list.render(employees)

	edit: (event) ->
		if @employee?
			@navigate '/employees', @employee.id, 'edit'

	handleActive: =>
		# fetch data from data only once
		# if the view is activated by the view stack for the first time
		if @fetchData
			Employee.fetch()
			@fetchData = false
		#trigger render
		@render()

	add: (event) ->
		@navigate '/employees/new'

	delete: ->
		if @employee?
			Spine.trigger 'EmployeeEvent:DELETE', @employee


###
	Controller to edit (or delete) an employee
###
class EditEmployee extends Spine.Controller

	className:
		'employee-edit'

	elements:
		'form': 'form'

	events:
		'submit form': 'save'       # clicking Save button
		'click .bBack': 'back'      # clicking Back button
		'click .bDelete': 'delete'  # clicking Delete button

	constructor: ->
		super
		@active @render

	render: (params) =>
		@employee = Employee.find params.id
		@html @view('employees/edit')( employee: @employee )

	delete: ->
		event.preventDefault()
		Spine.trigger 'EmployeeEvent:DELETE', @employee

	back: ->
		@navigate '/employees'

	save: (event) ->
		event.preventDefault()
		@employee.fromForm(@form).save()
		@navigate '/employees'


###
	Controller to add an employee
###
class NewEmployee extends Spine.Controller

	className:
		'employee-new'

	elements:
		'form': 'form'

	events:
		'submit form': 'save'          # submit form
		'click .bCancel': 'cancel'      # clicking Cancel button

	constructor: ->
		super
		@active @render

	render: =>
		@html @view('employees/new')()

	cancel: ->
		@navigate '/employees'

	save: (event) ->
		event.preventDefault()
		employee = Employee.fromForm(@form).save()
		@navigate '/employees' if employee



###
	ViewStack of all employees-views (index/edit/new)
###
class EmployeesViewStack extends Spine.Stack

	className:
		'employees-view stack'

	controllers:
		index: EmployeesOverview
		edit: EditEmployee
		new: NewEmployee

	# Note: Avoid index as a default controller
	# because it is activated and fetches data before an user is logged in
	#default: 'index'