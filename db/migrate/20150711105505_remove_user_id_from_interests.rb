class RemoveUserIdFromInterests < ActiveRecord::Migration
  def change
    remove_column :interests, :user_id, :integer
  end
end
