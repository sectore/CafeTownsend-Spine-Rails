class App.Session extends Spine.Model
	@configure 'Session', 'name', 'password', 'authorized'

	@extend Spine.Model.Ajax