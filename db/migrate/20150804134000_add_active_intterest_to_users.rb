class AddActiveIntterestToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_interest, :integer
  end
end
