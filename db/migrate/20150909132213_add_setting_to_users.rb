class AddSettingToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :message_notification, :boolean ,default: :true 
  	add_column :users, :friend_request_notification, :boolean,:default=>true
  	add_column :users, :new_event_notification, :boolean,:default=>true
  	add_column :users, :updates_notification, :boolean,:default=>true
  end
end
