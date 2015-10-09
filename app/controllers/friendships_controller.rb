class FriendshipsController < ApplicationController

  def create
	@user = User.find(params[:requestee_id])
	current_user.request_friendship(@user)
	respond_to do |format|
	  FriendshipMailer.requested_friendship(@user)
	  format.html { redirect_to @user }
	  format.js {}
	end
  end

  def update
	@user = User.find(params[:other_user_id])
	respond_to do |format|
	  if current_user.get_relationship(@user).update_attributes(friends: true)
		format.html { redirect_to @user }
		format.js {}
	  end
	end
  end

  def destroy
	@user = User.find(params[:other_user_id])
	@relationship = Friendship.find(params[:id])
	respond_to do |format|
	  if @relationship.destroy
		format.html { redirect_to @user }
		format.js {}
	  end
	end
  end

end
