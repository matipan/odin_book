require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  before(:example) do
	@matias = create(:user)
	sign_in @matias
  end

  describe "GET #home" do
    it "renders the correct template" do
	  get :home
	  expect(response).to render_template(:home)
	  expect(response.body).to eq ""
	end
  end

end
