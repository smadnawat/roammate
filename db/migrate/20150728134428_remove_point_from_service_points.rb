class RemovePointFromServicePoints < ActiveRecord::Migration
  def change
    remove_column :service_points, :point, :string
    add_column :service_points,:point,:integer,limit: 8
  end
end
