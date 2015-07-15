class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :reciever
      t.boolean :status
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
