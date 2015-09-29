require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  before(:example) do
	@matias = create(:user)
	sign_in @matias
	@matias.posts.create(body: "Hello world")
	@matias.posts.create(body: "Hello world")
  end

  context 'Creating a post' do
	describe "#create" do
	  subject { post :create, post: { body: "Hello TOP's" } }

	  it 'redirects to home after successfull creation, count up by one' do
		expect(subject).to redirect_to root_url
		expect{  post :create, post: { body: "Hello TOP's" } }.to change(Post, :count).by(+1)
	  end

	  subject { post :create, post: { body: "" } }

	  it 'redirects to home after failed created post, count doesn\'t change' do
		expect(subject).to redirect_to root_url
		expect{  post :create, post: { body: "" } }.to change(Post, :count).by(0)
	  end
	end

	describe "#destroy" do
	  subject { delete :destroy , id: @matias.posts.last }
	  it 'redirects to home after successfully destroyed a post, count down by one' do
		expect(subject).to redirect_to root_url
		expect{ delete :destroy, :id => @matias.posts.last }.to change(Post, :count).by(-1)
	  end
	end
  end
end
