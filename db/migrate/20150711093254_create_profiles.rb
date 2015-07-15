class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :image
      t.string :location
      t.string :gender
      t.boolean :status
      t.string :locale
      t.string :timezone
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
