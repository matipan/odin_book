require 'rails_helper'

RSpec.describe Post, type: :model do

  it { should validate_presence_of :body }
  it { should validate_presence_of :user_id }
  it { should validate_length_of(:body).is_at_most(1000) }
  it { should validate_length_of(:body).is_at_least(2) }
  it { should belong_to :user }

  describe "public instance methods" do
	let(:post)   { create(:post) }
	let(:matias) { create(:second_user) }

    context '#liked_by' do
      it 'creates a new like for the specfied post and user' do
		expect{post.liked_by(matias)}.to change(post.likes, :count).by(+1)
      end

	  it 'fails to create a like when already been liked' do
		post.liked_by(matias)
		expect{ post.liked_by(matias) }.not_to change(post.likes, :count)
	  end
    end

	context '#liked_by?' do
	  it 'returns true when a like exist' do
		post.liked_by(matias)
		expect(post.liked_by?(matias)).to be true
	  end

	  it 'returns false when a like does not exist' do
		expect(post.liked_by?(matias)).to be false
	  end
	end

	context '#get_liked_by' do
	  it 'returns the like when it exists' do
		post.liked_by(matias)
		expect(post.get_liked_by(matias)).to be_a(Like)
	  end

	  it 'returns nil when the like does not exists' do
		expect(post.get_liked_by(matias)).to be nil
	  end
	end
  end
end
