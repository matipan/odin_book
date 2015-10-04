class Post < ActiveRecord::Base

  # Associations
  has_attached_file :post_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  belongs_to :user
  has_many :likes

  # Validations
  validates_presence_of :body, :user_id
  validates_attachment_content_type :post_image, content_type: /\Aimage\/.*\Z/
  validates :body, length: { minimum: 2, maximum: 1000 }

end
