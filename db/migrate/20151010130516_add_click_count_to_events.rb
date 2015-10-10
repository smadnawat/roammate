class AddClickCountToEvents < ActiveRecord::Migration
  def change
    add_column :events, :click_count, :float, default: 0
  end
end
