require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:matias) { create(:user) }
  let(:martin) { create(:second_user) }

  before :example do
	sign_in matias
  end

  describe "#create" do

	context 'when a user requests a friendship' do
	  subject { post :create, { requestee_id: martin.id } }
	  it 'redirects to the users show page' do
		expect(subject).to redirect_to martin
	  end
	end
  end


  before :example do
	martin.request_friendship(matias)
  end

  describe "#update" do

	context 'when a user accepts a friendship' do
	  subject { patch :update, { id: matias.id, other_user_id: martin.id } }

      it 'redirects to the users show page' do
		expect(subject).to redirect_to martin
      end
    end
  end

  describe "#destroy" do
	context 'when a user rejects a request or deletes a friend' do
	  subject { delete :destroy, { id: matias.get_relationship(martin).id, other_user_id: martin.id } }

	  it 'redirects to the rejected or deleted user' do
		expect(subject).to redirect_to martin
	  end
    end
  end

end
