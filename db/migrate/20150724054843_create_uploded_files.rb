class CreateUplodedFiles < ActiveRecord::Migration
  def change
    create_table :uploded_files do |t|
      t.string :file

      t.timestamps null: false
    end
  end
end
