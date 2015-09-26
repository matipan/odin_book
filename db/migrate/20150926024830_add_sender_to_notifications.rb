class AddSenderToNotifications < ActiveRecord::Migration
  def change
	add_column :notifications, :sender_id, :integer

	add_index :notifications, :sender_id
	add_index :notifications, [ :sender_id, :user_id, :title ], unique: true
  end
end
