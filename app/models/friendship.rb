class Friendship < ActiveRecord::Base
  # Associations
  belongs_to :requester, class_name: "User"
  belongs_to :requestee, class_name: "User"

  # Validations
  validates_presence_of :requestee_id, :requester_id
end
