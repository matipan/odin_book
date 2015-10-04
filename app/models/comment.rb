class Comment < ActiveRecord::Base
  # Associations
  belongs_to :post
  belongs_to :user

  # Validations
  validates :body,  presence: true, length: { maximum: 1000 }
end
