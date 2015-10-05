class Like < ActiveRecord::Base
  # Associations
  belongs_to :post
  belongs_to :user

  # Validations
  validates_presence_of :post_id, :user_id
end
