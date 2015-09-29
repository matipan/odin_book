class StaticPagesController < ApplicationController
  before_action :authenticate_user!

  def home
	@post = current_user.posts.build
	@feed = current_user.feed
  end

end
