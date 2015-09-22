class CreateBlocks < ActiveRecord::Migration
  def change
    create_table :blocks do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :member_id
      t.boolean :is_block

      t.timestamps null: false
    end
  end
end
