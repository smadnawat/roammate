class CreateMessageCounts < ActiveRecord::Migration
  def change
    create_table :message_counts do |t|
      t.references :group, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.boolean :is_read

      t.timestamps null: false
    end
  end
end
