class LikesController < ApplicationController

  def create
	@post = Post.find(params[:post_id])
	respond_to do |format|
	  if @post.liked_by(current_user)
		format.js
		format.html { redirect_to root_url }
	  end
	end
  end

  def destroy
	@post = Post.find(params[:post_id])
	@like = Like.find(params[:id])
	respond_to do |format|
	  if @like.destroy
		format.js
		format.html { redirect_to root_url }
	  end
	end
  end

end
