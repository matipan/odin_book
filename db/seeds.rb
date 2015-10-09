User.create!(name: 					"Example",
			 last_name: 			"User",
			 email: 				"example@odinbookmp.org",
			 password: 			 	"password",
			 password_confirmation: "password")

99.times do |n|
  name 	   = Faker::Name.name
  last_name = Faker::Name.name
  email    = "example-#{n+1}@odinbookmp.org"
  password = "password"
  User.create!(name: 				  name,
			   last_name: 			  last_name,
			   email: 				  email,
			   password: 			  password,
			   password_confirmation: password)
end


users = User.order(:created_at).take(6)
99.times do
  body = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(body: body) }
end
users = User.all
i = 1
users.each do |user|
  (i..99).each do |n|
	user.request_friendship(users[n])
	users[n].accept_friend_request(user)
  end
  i += 1
end
