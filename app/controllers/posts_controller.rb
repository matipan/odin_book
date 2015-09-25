class PostsController < ApplicationController
  def index
  end

  def new
	@post = current_user.posts.build
  end

  def create
	@post = current_user.posts.build(post_params)
	if @post.save
	  flash[:success] = "Your post has been successfully posted."
	end
	redirect_to posts_path
  end

  private

	def post_params
	  params.require(:post).permit(:body, :user_id)
	end
end
