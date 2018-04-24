# Private Events

This is (ongoing) Rails project will build an events site similar to Eventbrite, which allows users to create events and manage user signups.

## Notes

# List of problems and my solutions

Note: This is a list of all points where I got stuck for at least a few minutes, and notes on what the solution was. It's here to remind me for the future and to chronicle my learning progression.

Problem: I forgot to pluralise the User controller when I generated in Rails. After googling, it seems the best way to fix this is destroy and redo.
To remember: by convention, model names are singular but controller names are plural (a User model; a Users controller).

Problem: Create new user form - first I couldn't get the form to create a new db entry, and then I couldn't get the form to redirect to the new user page when successful.

Solution: The UsersController#new needs to have a @user = User.new line so the form has something to iterate over. UsersController#create should have @user = User.new(user_params), and then @user.save. Then the user signup form can read: form_for @user (with no users_new_path argument required). Then when you redirect_to @user, Rails knows to render the show.html.erb template (as long as UsersController#show has '@user = User.find(params[:id])')
