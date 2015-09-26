class AddTitleAndMessageToNotifications < ActiveRecord::Migration
  def change
	add_column :notifications, :title, :string
	add_column :notifications, :message, :string
  end
end
