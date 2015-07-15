class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :reciever
      t.string :content
      t.string :image
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
