class StaticPagesController < ApplicationController

  def home
	@post = current_user.posts.build
	@feed = current_user.feed
  end

end
