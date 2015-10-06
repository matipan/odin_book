class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
	:recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :posts, dependent: :destroy
  has_many :requested_friendships, class_name: "Friendship", foreign_key: :requester_id, dependent: :destroy
  has_many :friends, through: :requested_friendships, source: :requestee
  has_many :received_friendships, class_name: "Friendship", foreign_key: :requestee_id, dependent: :destroy
  has_many :received_friends, through: :received_friendships, source: :requester
  has_many :notifications, dependent: :destroy, foreign_key: :user_id
  has_many :sent_notifications, class_name: "Notification", dependent: :destroy, foreign_key: :sender_id
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Validations
  validates_presence_of :name, :last_name

  ################
  # User methods #
  ################

  def request_friendship(other_user)
	# send friend request, no need to send friends: false, since default is set to false in the db
	if good_to_go?(other_user)
	  self.requested_friendships.create(requestee_id: other_user.id) if good_to_go?(other_user)
	  if !other_user.notifications.where(sender_id: self.id, title: "request", message:
										"#{self.name.capitalize} #{self.last_name.capitalize} wants to be friends with you.").any?
		other_user.notifications.create(sender_id: self.id, title: "request", message:
										"#{self.name.capitalize} #{self.last_name.capitalize} wants
										to be friends with you.")
	  end
	end
  end

  # True when friends = true, false otherwise
  def has_friendship?(other_user)
	!get_friendship(self, other_user).nil?
  end

  # When friends = false and a request has already been sent
  def has_requested?(other_user)
	!get_request(other_user, self).nil?
  end

  # Returns true when current user requested the friendship
  def requested_to?(other_user)
	has_requested?(other_user) && get_request(other_user, self).requester == self ? true : false
  end

  # Status of relationship
  def status(other_user)
	if has_friendship?(other_user)
	  return "friends"
	elsif has_requested?(other_user)
	  if requested_to?(other_user)
		return 'i_requested'
	  else
		return 'i_received'
	  end
	end
  end

  # Returns the relationship, a Friendship object
  def get_relationship(other_user)
	get_request(other_user,self).nil? ? get_friendship(self,other_user) : get_request(other_user,self)
  end

  # current_user accepts a friend request from other_user
  def accept_friend_request(other_user)
	friendship = get_request(other_user, self)
	if friendship
	  friendship.update_attributes(friends: true)
	  other_user.notifications.create(sender_id: self.id, title: "accept_request", message: "You are now friends with #{self.name.capitalize} #{self.last_name.capitalize}.")
	end
  end

  # current_user rejects a friends request from other_user
  def reject_friend_request(other_user)
	friendship = get_request(other_user, self)
	friendship.destroy if friendship
  end

  # Removes current relation between current_user and other_user
  def delete_friendship(other_user)
	get_friendship(self, other_user).destroy if has_friendship?(other_user)
  end

  # Returns ActiveRecord::Relation with all his friends(those with friends = true)
  def get_all_friends
	friends_requested_ids = "SELECT requestee_id FROM friendships WHERE requester_id = :user_id AND friends = true"
	friends_received_ids  = "SELECT requester_id FROM friendships WHERE requestee_id = :user_id AND friends = true"
	User.where("id IN (#{friends_requested_ids}) OR id IN (#{friends_received_ids})", user_id: self.id)
  end

  # Returns the feed of the current user
  def feed
	friends_requested_ids = "SELECT requestee_id FROM friendships WHERE requester_id = :user_id AND friends = true"
	friends_received_ids  = "SELECT requester_id FROM friendships WHERE requestee_id = :user_id AND friends = true"
	Post.where("user_id IN (#{friends_requested_ids}) OR user_id in (#{friends_received_ids}) OR user_id = :user_id", 
			   user_id: self.id).order(created_at: :desc)
  end

  private

	# Returns the request that `from` has made to `to`
	def get_request(from, to)
	  from.requested_friendships.find_by(requestee_id: to.id, friends: false) ||
		to.requested_friendships.find_by(requestee_id: from.id, friends: false)
	end

	# Returns an ActiveRecord::Relation[Friendship] with the current friendship if any
	def get_friendship(current_user, other_user)
	  current_user.requested_friendships.find_by(requestee_id: other_user.id, friends: true) ||
		other_user.requested_friendships.find_by(requestee_id: current_user.id, friends: true)
	end

	# Check that current_user and other_user aren't friends and that friend requests haven't been sent
	def good_to_go?(other_user)
	  get_friendship(self,other_user).nil? && get_request(other_user, self).nil?
	end

end
