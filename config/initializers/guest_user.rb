# make a guest user
# this user will be the default user to display on
# if no one logs in
user = User.where(email: 'guest_user@example.com')
unless user.any?
  User.create!(email: 'guest_user@example.com', password: 'hhhhhhhh')
end
