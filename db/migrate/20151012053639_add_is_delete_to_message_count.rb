class AddIsDeleteToMessageCount < ActiveRecord::Migration
  def change
    add_column :message_counts, :is_delete, :boolean, default: false
  end
end
