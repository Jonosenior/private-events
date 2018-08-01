# Private Events

This is an events site, similar to Eventbrite, which allows users to create events and invite other other users to attend.


## Feature Spec
- User can sign up with name, email and password, and can log in.
- Logged-in users can create events, invite other users to her own events, and delete her own events.
- User can be either an event host or an event attendee.
- The Event index is organised into upcoming and past events.

## Domain Model

There is a User model, an Event model and an Attendance model. A user can create events, and attend many events. An event belongs to one creator and has many attendees. The many-to-many relationship between events and attendees is captured in the attendance model.

#### User model
- name: string
- email: string
- password_digest: string

#### Event model
- name: string
- description: text
- date_time: datetime
- location: string
- creator_id: integer

#### Attendance model
- user_id: integer
- event_id: integer

## Notes

# List of problems and my solutions

Note: This is a list of all issues where I got stuck for at least a few minutes, and notes on what the solution was. It's here to help me in the future, and to chronicle my learning progression.

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

Problem: Cannot get valid Event test to pass: the error was no creator, but when I tried to add a creator_id this didn't work.
Solution: build the event like this: users(:valid).created_events.new(...). This is how the controller creates an event, and will automatically use the :valid user fixture.
Solution 2: You CAN add a creator directly to the event fixture. But don't use a creator_id column: use a 'creator' column (no id suffix) and put the creator id in there.

Problem: In EventsControllerTest, I get a 'no method "name"' error when checking if the index action would return success.
Solution: This took an a while, and many people looking at it. Firstly, I had to get the fixture set up correctly (see above - add a creator field to the event, populated with the fixture's ID). Secondly, I had added Bootstrap Sprockets but not changed the filetype of app/assets/stylesheets/application.css to application.scss. This fixed it...

Problem: In EventsControllerTest, the assert_difference method is returning incorrect result.
Solution: The method takes an optional argument showing which difference is to be expected. Since the default is 0, the test fails unless you set this to -1 (ie, one event is deleted).

Problem: In my integration events_create_test, I couldn't work out how to assert that the name of an invalid user wasn't present on the page.
Solution: Use assert_select to target the div, then add a hash containing the count key, like so:
```ruby
assert_select "div", { html: /Dan/, count: 0 }, "Non-existent users should not appear"
```
