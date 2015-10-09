class FriendshipMailer < ApplicationMailer
  default from: "odinbookmp@gmail.com"

  def requested_friendship(user)
	mail to: user.email, subject: "#{current_user.full_name} wants to be your friend."
  end
end
