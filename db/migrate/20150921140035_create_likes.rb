class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :user, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.boolean :status, default: false

      t.timestamps null: false
    end
  end
end
