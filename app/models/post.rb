class Post < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :likes

  # Validations
  validates_presence_of :body, :user_id
  validates :body, length: { minimum: 2, maximum: 1000 }

end
