class RemoveAttributeFromProfiles < ActiveRecord::Migration
  def change
    remove_column :profiles, :locale, :string
    remove_column :profiles, :timezone, :string
  end
end
