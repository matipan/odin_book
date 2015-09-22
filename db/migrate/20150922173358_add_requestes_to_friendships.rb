class AddRequestesToFriendships < ActiveRecord::Migration
  def change
	add_column :friendships, :requester_id, :integer
	add_column :friendships, :requestee_id, :integer

	add_index :friendships, :requester_id
	add_index :friendships, :requestee_id
	add_index :friendships, [ :requester_id, :requestee_id ], unique: true
  end
end
