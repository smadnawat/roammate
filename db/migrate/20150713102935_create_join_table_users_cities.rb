class CreateJoinTableUsersCities < ActiveRecord::Migration
  def up
  	create_table 'users_cities', :id => false do |t|
	    t.column :user_id, :integer
	    t.column :city_id, :integer
	  end  
  end
end
