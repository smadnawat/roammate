class AddLatitudeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
    add_column :users, :online, :boolean
    add_column :users, :current_city, :string
    remove_column :profiles, :current_city ,:string
  end
end
