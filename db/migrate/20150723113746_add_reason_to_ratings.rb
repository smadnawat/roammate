class AddReasonToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :reason, :string
  end
end
