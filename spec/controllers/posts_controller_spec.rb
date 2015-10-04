require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:matias) { create :user }

  before(:example) do
	sign_in matias
  end

  describe "#create" do
	subject { post :create, post: { body: "Hello TOP's" }, format: :json }

	it 'redirects to home after successfull creation, count up by one' do
	  expect(subject.status).to eq(422)
	  expect{  post :create, post: { body: "Hello TOP's" } }.to change(Post, :count).by(+1)
	end

	subject { post :create, post: { body: "" }, format: :json }

	it 'redirects to home after failed created post, count doesn\'t change' do
	  expect(subject.status).to eq(422)
	  expect{  post :create, post: { body: "" }, format: :json }.to change(Post, :count).by(0)
	end
  end

  describe "#destroy" do
	before :example do
	  matias.posts.create(body: "Hello world")
	  matias.posts.create(body: "Hello world")
	end

	subject { delete :destroy , id: matias.posts.last }
	it 'redirects to home after successfully destroyed a post, count down by one' do
	  expect(subject).to redirect_to root_url
	  expect{ delete :destroy, :id => matias.posts.last }.to change(Post, :count).by(-1)
	end
  end
end
