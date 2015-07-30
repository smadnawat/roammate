class AddCurrentCityToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :current_city, :string
  end
end
