class Post < ActiveRecord::Base

  # Associations
  has_attached_file :post_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  belongs_to :user
  has_many :likes, dependent: :destroy

  # Validations
  # validate :body_or_image
  validates_presence_of :body
  validates_attachment_content_type :post_image, content_type: /\Aimage\/.*\Z/
  validates :body, length: { maximum: 1000 }


  def body_or_image
	errors.add(:at_least_one, "You must provide a body or an image.") if body.blank? && post_image.blank?
  end

end
