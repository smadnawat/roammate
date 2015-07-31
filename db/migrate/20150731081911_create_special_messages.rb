class CreateSpecialMessages < ActiveRecord::Migration
  def change
    create_table :special_messages do |t|
      t.string :content
      t.references :interest, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
