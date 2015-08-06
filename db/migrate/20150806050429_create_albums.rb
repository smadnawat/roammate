class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :image
      t.boolean :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
