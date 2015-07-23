class AddUserTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :user_type, :string
  end
end
