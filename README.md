# Private Events

This is (ongoing) Rails project will build an events site similar to Eventbrite, which allows users to create events and manage user signups.

## Notes

# List of problems and my solutions

Note: This is a list of all points where I got stuck for at least a few minutes, and notes on what the solution was. It's here to remind me for the future and to chronicle my learning progression.

Problem: I forgot to pluralise the User controller when I generated in Rails. After googling, it seems the best way to fix this is destroy and redo.
To remember: by convention, model names are singular but controller names are plural (a User model; a Users controller).

Problem: Create new user form - first I couldn't get the form to create a new db entry, and then I couldn't get the form to redirect to the new user page when successful.

Solution: The UsersController#new needs to have a @user = User.new line so the form has something to iterate over. UsersController#create should have @user = User.new(user_params), and then @user.save. Then the user signup form can read: form_for @user (with no users_new_path argument required). Then when you redirect_to @user, Rails knows to render the show.html.erb template (as long as UsersController#show has '@user = User.find(params[:id])')

Problem: Couldn't remember the exact steps for user login.
Solution: Wrote a detailed checklist for setting up user login to use in future projects.

Problem: Couldn't destroy an event from the database in console.
Solution: The problem was that Rails didn't know what to do with the associations connected to the Event instance in other tables (eg attendings table). By adding :dependent => :destroy, you destroy those dependencies too.

Problem: Couldn't work out how to add attendees to an event - the models for User (as :attendee) and Event are connected by the through table and model Attendance.
Solution: The trick is to add directly to the model of the join table. eg Attendance.new(:user_id, :event_id). Then Active Record can access attendees for an event with event.attendees.

Problem: Didn't know how to edit an event on console (eg, change the creator_id).
Solution: e = Event.last; e.creator_id = 4; e.save

Problem: When I delete a User in console, the user's created events does not get deleted - even though
Solution: The difference between #delete and #destroy. #destroy activates the :dependent association options (eg dependent: :destroy), whereas #delete simply removes the entry from the db.

Problem: When I try to test a valid user fixture, it fails due to the password. What password-related fields should I use in my fixture, if the model relies on the #has_secure_password method?
Solution: In the model, don't test for presence of password. This will break your tests, and is not required since #has_secure_password validates for presence anyway (it doesn't validate length or anything else, though). Then your fixture needs to contain a password_confirmation field, containing a digest produced by bcrypt:
  password_digest: <%= BCrypt::Password.create('donuts') %>
