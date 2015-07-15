class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :group_name
      t.integer :group_admin

      t.timestamps null: false
    end
  end
end
