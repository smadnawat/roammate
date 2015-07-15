class CreateJoinTableUsersInterests < ActiveRecord::Migration
   def up
	  	create_table 'users_interests', :id => false do |t|
		    t.column :user_id, :integer
		    t.column :interest_id, :integer
		end  
   end
end
