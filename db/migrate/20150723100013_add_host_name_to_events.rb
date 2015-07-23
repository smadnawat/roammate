class AddHostNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :host_name, :string
  end
end
