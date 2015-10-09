require 'rails_helper'
require 'support/friending_steps'
require 'support/login_steps'

RSpec.feature "FriendingManagments", type: :feature do
  include LoginSteps
  include FriendingSteps

  let(:matias) { create :user }
  let(:martin) { create :second_user }
  before :example do
    login_with(matias)
  end

  context 'when they\'re already friends' do
    before :example do
      make_them_be_friends(matias, martin)
	  visit_user(martin)
    end

	it 'has a Remove friendship button' do
	  it_should_have_remove_friendship_form
	end

	it 'removes the friendship' do
	  it_should_remove_friendship
	end
  end

  context 'when they\'re not friends' do
    before :example do
	  visit_user(martin)
    end

	it 'can request friendship' do
	  it_should_have_send_request_form
	  send_friendship_request(matias, martin)
	  it_should_have_remove_friendship_form
	end

	context 'someone requests to logged in user' do
	  before :example do
		logout_to(matias)
		login_with(martin)
	    send_friendship_request(martin, matias)
		logout_to(martin)
		login_with(matias)
		visit_user(martin)
	  end

	  it 'has both options(accept and decline)' do
		it_should_have_accept_friendship_form
		it_should_have_remove_friendship_form
	  end

	  it 'accepts a friend request' do
	    accept_a_request_from(martin)
		it_should_have_remove_friendship_form
	  end

	  it 'declines a friend request' do
		decline_a_request_from(martin)
	    it_should_have_send_request_form
	  end
	end
  end
end
