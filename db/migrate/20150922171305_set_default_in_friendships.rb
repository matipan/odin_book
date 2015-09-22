class SetDefaultInFriendships < ActiveRecord::Migration
  def change
	remove_column :friendships, :state
	add_column :friendships, :friends, :boolean, default: false
  end
end
