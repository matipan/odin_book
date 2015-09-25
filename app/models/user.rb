class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :requested_friendships, class_name: "Friendship", foreign_key: :requester_id, dependent: :destroy
  has_many :friends, through: :requested_friendships, source: :requester
  has_many :received_friendships, class_name: "Friendship", foreign_key: :requestee_id, dependent: :destroy
  has_many :received_friends, through: :received_friendships, source: :requestee

  # Validations
  validates_presence_of :name, :last_name

  ################
  # User methods #
  ################

end
