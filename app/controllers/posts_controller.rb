class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
	@post = current_user.posts.build
  end

  def create
	@post = current_user.posts.build(post_params)
	if @post.save
	  flash[:success] = "Your post has been successfully posted."
	end
	redirect_to root_url
  end

  def destroy
	@post = Post.find(params[:id])
	if @post.destroy
	  redirect_to root_url
	end
  end

  private

	def post_params
	  params.require(:post).permit(:body, :user_id)
	end

end
