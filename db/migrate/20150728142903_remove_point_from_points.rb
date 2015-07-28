class RemovePointFromPoints < ActiveRecord::Migration
  def change
    remove_column :points, :point, :integer
    remove_column :points,:pointable_id,:integer
  end
end
