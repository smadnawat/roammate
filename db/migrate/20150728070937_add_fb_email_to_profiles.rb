class AddFbEmailToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :fb_email, :string
  end
end
