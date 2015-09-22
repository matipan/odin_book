class Post < ActiveRecord::Base

  # Associations
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  belongs_to :user
  has_many :likes, dependent: :destroy

  # Validations
  validate :body_or_image
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates :body, length: { maximum: "1000" }


  def body_or_image
	errors.add(:at_least_one, "You must provide a body or an image.") if body.blank? && post_image.blank?
  end

end
