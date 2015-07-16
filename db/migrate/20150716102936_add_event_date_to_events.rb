class AddEventDateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_date, :string
  end
end
