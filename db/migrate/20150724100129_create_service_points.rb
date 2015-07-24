class CreateServicePoints < ActiveRecord::Migration
  def change
    create_table :service_points do |t|
      t.string :service
      t.string :point

      t.timestamps null: false
    end
  end
end
