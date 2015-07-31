class AddBannerToInterest < ActiveRecord::Migration
  def change
    add_column :interests, :banner, :string
  end
end
