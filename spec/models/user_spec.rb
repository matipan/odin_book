require 'rails_helper'

RSpec.describe User, type: :model do

  it { should validate_presence_of :name }
  it { should validate_presence_of :last_name }

  describe "public instance methods" do
	context 'friends associations' do
	  # build users before each example
	  before(:example) do
		@matias 	= create(:user)
		@other_user = create(:second_user)
	  end

	  it 'sends a friend request' do
		@other_user.request_friendship(@matias)
		expect(@matias.received_friendships.count).to be == 1
		expect(@matias.notifications.count).to be == 1
	  end

	  it 'accepts a friend request / #get_all_friends' do
		@other_user.request_friendship(@matias)
		@matias.accept_friend_request(@other_user)
		expect(@matias.get_all_friends.count).to be == 1
		expect(@matias.notifications.count).to be == 1
	  end

	  it 'accepts a friend request / #has_friendship?' do
		@other_user.request_friendship(@matias)
		@matias.accept_friend_request(@other_user)
		expect(@matias.has_friendship?(@other_user)).to be true
		expect(@matias.notifications.count).to be == 1
	  end

	  it 'rejects a friend request / #reject_friend_request' do
		@other_user.request_friendship(@matias)
		@matias.reject_friend_request(@other_user)
		expect(@matias.received_friendships.count).to be == 0
	  end

	  it 'deletes a current friendship / #delete_friendship' do
		@other_user.request_friendship(@matias)
		@matias.accept_friend_request(@other_user)
		expect(@matias.has_friendship?(@other_user)).to be true
		@matias.delete_friendship(@other_user)
		expect(@matias.has_friendship?(@other_user)).to be false
	  end

	  it 'sends a friend request to a current friend' do
		@other_user.request_friendship(@matias)
		@matias.accept_friend_request(@other_user)
		expect(@other_user.request_friendship(@matias)).to be nil
	  end
	end

	context 'feed of the user' do
	  before(:example) do
		@matias 	= create(:user)
		@other_user = create(:second_user)
		@other_user.request_friendship(@matias)
		@matias.accept_friend_request(@other_user)
		2.times do |n|
		  @other_user.posts.create(body: "Hello world this is the post number #{n}")
		  @matias.posts.create(body: "Hello world this is matias with my post number #{n}")
		end
	  end

	  it 'gets the feed of friends and self / #feed' do
		@other_user.posts.each do |post|
		  expect(@matias.feed.include?(post)).to be true
		  expect(@other_user.feed.include?(post)).to be true
		end
		@matias.posts.each do |post|
		  expect(@matias.feed.include?(post)).to be true
		  expect(@other_user.feed.include?(post)).to be true
		end
	  end
	end
  end
end
