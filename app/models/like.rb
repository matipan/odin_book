class Like < ActiveRecord::Base
  # Associations
  belongs_to :post
  belongs_to :user
end
