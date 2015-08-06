class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message
      t.string :type
      t.boolean :status
      t.integer :reciever
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
