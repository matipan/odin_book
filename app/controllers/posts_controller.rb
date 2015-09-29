class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
	@post = current_user.posts.build
  end

  def create
	@post = current_user.posts.build(post_params)
	respond_to do |format|
	  if @post.save
		format.js {}
		format.html { redirect_to root_url }
		format.json { render 'static_pages/home', status: :created }
	  else
		format.html { render :new }
		format.json { render json: @post.errors, status: :unprocessable_entity }
		format.js
	  end
	end
  end

  def destroy
	@post = Post.find(params[:id])
	respond_to do |format|
	  if @post.destroy
		format.html { redirect_to root_url }
		format.js {}
	  end
	end
  end

  private

	def post_params
	  params.require(:post).permit(:body, :user_id)
	end

end
