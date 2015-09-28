require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  before(:example) do
	@matias = create(:user)
	sign_in @matias
  end

  context 'Creating a post' do
	describe "#create" do
	  subject { post :create, post: { body: "Hello TOP's" } }

	  it 'redirects to home after successfull creation' do
		expect(subject).to redirect_to root_url
	  end

	  subject { post :create, post: { body: "" } }

	  it 'redirects to home after failed created post' do
		expect(subject).to redirect_to root_url
	  end
	end
  end

end
