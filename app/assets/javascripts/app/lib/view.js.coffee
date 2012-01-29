Spine.Controller.include

	###
       helper method for rendering eco templates
	###
	view: (name) ->
		JST["app/views/#{name}"]