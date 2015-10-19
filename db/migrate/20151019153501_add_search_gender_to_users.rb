class AddSearchGenderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :search_gender, :string, default: ''
  end
end
