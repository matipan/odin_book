class NotificationsController < ApplicationController

  def index
  end

  def destroy
	@notification = Notification.find(params[:id])
	sender_id = @notification.sender_id
	case @notification.title
	when "accept_request"
	  redirect_to user_path(User.find(sender_id)) if @notification.destroy
	when "request"
	  redirect_to user_path(User.find(sender_id)) if @notification.destroy
	else
	  redirect_to root_url
	end
  end

end
