module FriendingSteps

  def make_them_be_friends(requester, requestee)
	visit_user(requestee)
	click_button "Add friend"
	logout_to(requester)
	login_with(requestee)
	visit_user(requester)
	click_button "Accept friendship"
	logout_to(requestee)
	login_with(requester)
  end

  def visit_user(user)
	visit("/users/#{user.id}")
  end

  def send_friendship_request(requester, requestee)
	visit_user(requestee)
	click_button "Add friend"
  end

  def accept_a_request_from(requestee)
	visit_user(requestee)
	click_button "Accept friendship"
  end

  def decline_a_request_from(requestee)
	visit_user(requestee)
	click_button "Decline request"
  end

  def it_should_have_remove_friendship_form
	expect(page).to have_css("div#remove_friendship_form")
  end

  def it_should_remove_friendship
	it_should_have_remove_friendship_form
	click_button "Remove friendship"
	it_should_have_send_request_form
  end

  def it_should_have_send_request_form
	expect(page).to have_css("div#send_request_form")
  end

  def it_should_have_accept_friendship_form
	expect(page).to have_css("div#accept_friendship_form")
  end

end
