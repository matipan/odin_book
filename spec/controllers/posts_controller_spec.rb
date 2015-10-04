require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:matias) { create :user }

  before(:example) do
	sign_in matias
  end

  describe "#create" do
	context 'when a user submits a valid post' do
	  subject { post :create, post: { body: "Hello TOP's" }, format: :js }

	  it 'redirecs to home with the count up by one' do
		expect(subject.status).to eq(200)
		expect{ post :create, post: { body: "Hello TOP's" }, format: :js }.to change(Post, :count).by(+1)
	  end
	end

	context 'when a user submits an invalid post' do
	  subject { post :create, post: { body: "" }, format: :js }

	  it 'redirects to home with count unchanged' do
		expect(subject.status).to eq(200)
		expect{subject}.to change(Post, :count).by(0)
	  end

	end
  end

  describe "#destroy" do
	before :example do
	  matias.posts.create(body: "Hello world")
	  matias.posts.create(body: "Hello world")
	end

	context 'when a user destroys a post' do
	  subject { delete :destroy , id: matias.posts.last }

	  it 'redirects to home with count down by one' do
		expect(subject).to redirect_to root_url
		expect{ delete :destroy, :id => matias.posts.last }.to change(Post, :count).by(-1)
	  end
	end
  end
end
