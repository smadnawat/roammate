class AddMessageIdToMessageCounts < ActiveRecord::Migration
  def change
    add_column :message_counts, :message_id, :integer
  end
end
