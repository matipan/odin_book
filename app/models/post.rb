class Post < ActiveRecord::Base

  # Associations
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validations
  validates_presence_of :body, :user_id
  validates :body, length: { minimum: 2, maximum: 1000 }

  ################
  # Post methods #
  ################

  def liked_by(user)
	self.likes.create(user_id: user.id) if !liked_by?(user)
  end

  def liked_by?(user)
	!get_like(user).nil?
  end

  def get_liked_by(user)
	get_like(user)
  end

  def not_liked_by(user)
	get_like(user).destroy
  end

  private

	def get_like(user)
	  Like.find_by(user_id: user.id, post_id: self.id)
	end

end
