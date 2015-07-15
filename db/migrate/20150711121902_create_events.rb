class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_name
      t.string :place
      t.date :start_date
      t.date :end_date
      t.string :link
      t.string :city

      t.timestamps null: false
    end
  end
end
