class Comment < ActiveRecord::Base
  # Associations
  belongs_to :post
  belongs_to :user

  # Validations
  validates :body,  presence: true, length: { minimum: 2, maximum: 1000 }
  validates_presence_of :user_id, :post_id
end
