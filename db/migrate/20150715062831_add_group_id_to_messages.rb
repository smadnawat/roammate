class AddGroupIdToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :group_id, :integer
  end
end
