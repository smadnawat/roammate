class RemoveRecieveFromMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :reciever, :integer
  end
end
