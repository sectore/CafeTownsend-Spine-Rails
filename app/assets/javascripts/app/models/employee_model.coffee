class App.Employee extends Spine.Model
	@configure 'Employee', 'first_name', 'last_name', 'start_date', 'email'

	@extend Spine.Model.Ajax