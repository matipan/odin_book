FactoryGirl.define do
  factory :user do
	name "Matias"
	last_name "Pan"
	email "asdsadasdsad@valid.com"
	password "password"
	id 1
  end

  factory :second_user, class: User do
	name "Second"
	last_name "User"
	email "sdsadasdasd@valid.com"
	password "password"
	id 2
  end

end
