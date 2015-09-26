class Notification < ActiveRecord::Base
  # Associations
  belongs_to :user
  belongs_to :sender, class_name: "User"

  # Validations
  validates_presence_of :title, :user_id, :message
end
