class AddInterestIdToEvents < ActiveRecord::Migration
  def change
    add_reference :events, :interest, index: true, foreign_key: true
  end
end
