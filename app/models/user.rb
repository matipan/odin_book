class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :requested_friendships, foreign_key: :requester_id, class_name: "Friendship", dependent: :destroy
  has_many :requested_friends, through: :requested_friends, source: :requester
  has_many :received_friendships, foreign_key: :requestee_id, class_name: "Friendship", dependent: :destroy
  has_many :received_friends, through: :received_friendships, source: :requestee
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Validations
  validates_presence_of :name, :last_name
end
