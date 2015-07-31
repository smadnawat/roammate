class AddStatusToSpecialMessages < ActiveRecord::Migration
  def change
    add_column :special_messages, :status, :boolean
  end
end
