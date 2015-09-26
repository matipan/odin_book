class StaticPagesController < ApplicationController

  def home
	@feed = current_user.feed
  end

end
