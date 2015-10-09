class UsersController < ApplicationController
  before_action :find_user, only: [ :show, :friends, :requests ]

  def show
	@posts = @user.posts.paginate(page: params[:page], per_page: 15)
  end

  def index
	@users = User.paginate(page: params[:page]).order(created_at: :desc)
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
