class UsersController < ApplicationController
  before_action :find_user, only: [ :show, :friends, :requests ]

  def show
  end

  def friends
	@friends = @user.get_all_friends
  end

  def requests
	@requests = @user.get_all_requests
  end

  private

	def find_user
	  @user = User.find(params[:id])
	end

end
