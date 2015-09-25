FactoryGirl.define do
  factory :user do
	name "Matias"
	last_name "Pan"
	email "matias@valid.com"
	password "password"
  end

  factory :second_user, class: User do
	name "Second"
	last_name "User"
	email "second@valid.com"
	password "password"
  end

end
