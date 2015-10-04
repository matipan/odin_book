require 'rails_helper'

RSpec.feature "PostsManagments", type: :feature do
  let(:matias) { create(:user) }
  before :example do
    visit new_user_session_path
	fill_in "user_email", with: matias.email
	fill_in "user_password", with: matias.password
	click_button "Log in"
	visit('/')
  end

  describe "Posts creation" do
	context 'when a user submits a valid post' do
      it 'adds the post to the home page' do
		fill_in "post-body", with: "Some body of some post"
		click_button "Post"
		expect(page).to have_text("Some body of some post")
      end
    end

	context 'when a user submits an invalid post' do
	  it 'does not add the post to the home page' do
		fill_in "post-body", with: " "
		click_button "Post"
		expect(page).not_to have_text("")
	  end
	end
  end

end
