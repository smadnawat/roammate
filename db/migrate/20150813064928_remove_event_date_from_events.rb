class RemoveEventDateFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :event_date, :string
    add_column :events, :event_date, :datetime
  end
end
