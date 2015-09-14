class AddColorToInterest < ActiveRecord::Migration
  def change
    add_column :interests, :color, :string
  end
end
