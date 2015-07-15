class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :city_name
      t.string :state
      t.string :country
      t.boolean :status

      t.timestamps null: false
    end
  end
end
