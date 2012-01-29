#Spine + Rails port of Cafe Townsend application

##About
[Spine](http://spinejs.com/) and [Rails](http://rubyonrails.org/) port of the famous Cafe Townsend application originally written in ActionScript. This is part 2 of the demo ["CafeTownsend-Spine"](https://github.com/sectore/CafeTownsend-Spine) - now with running Rails at the back-end.

##Screen shots
[![Click on screen shot to see live demo on Heroku](https://github.com/sectore/CafeTownsend-Spine-Rails/raw/master/wiki/cafetownsend-spine-rails-login.png "Login")](http://cafetownsend-spine-rails.herokuapp.com)

[![Click on screen shot to see live demo on Heroku](https://github.com/sectore/CafeTownsend-Spine-Rails/raw/master/wiki/cafetownsend-spine-rails-overview.png "Overview")](http://cafetownsend-spine-rails.herokuapp.com)

[![Click on screen shot to see live demo on Heroku](https://github.com/sectore/CafeTownsend-Spine-Rails/raw/master/wiki/cafetownsend-spine-rails-edit.png "Edit")](http://cafetownsend-spine-rails.herokuapp.com)


##Live example
[http://cafetownsend-spine-rails.herokuapp.com](http://cafetownsend-spine-rails.herokuapp.com/)

##Local installation
1) Open Terminal

	git clone git://github.com/sectore/CafeTownsend-Spine-Rails.git
	cd CafeTownsend-Spine-Rails
	bundle install --without production
	rake db:migrate
	rake db:seed
	rails server

2) Open [http://localhost:3000](http://localhost:3000/) using [Chrome](https://www.google.com/chrome)

##Author
Jens Krause // [WEBSECTOR.DE](http://www.websector.de)

Please note:
Coming from a strong [ActionScript background](http://www.websector.de) this demo is a personal project for a better understanding of using [Spine](http://spinejs.com/) and [Rails](http://rubyonrails.org). Any tips or improvements are welcome!

