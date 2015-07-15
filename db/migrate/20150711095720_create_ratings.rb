class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :rate
      t.integer :rater_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
