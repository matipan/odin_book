require 'rails_helper'
require 'support/post_steps'
require 'support/login_steps'

RSpec.feature "PostsManagments", type: :feature do
  include PostSteps
  include LoginSteps

  let(:matias) { create(:user) }
  before :example do
	login_with(matias)
	visit('/')
  end

  describe "Posts creation" do
	context 'when a user submits a valid post' do
      it 'adds the post to the home page' do
		i_should_see_the_new_post("Some body og some post")
      end
    end

	context 'when a user submits an invalid post' do
	  it 'does not add the post to the home page' do
	  end
	end
  end

end
