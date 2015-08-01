class AddAddressToCurrentLocations < ActiveRecord::Migration
  def change
    add_column :current_locations, :address, :string
  end
end
