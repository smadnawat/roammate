class CreateJoinTableUsersCategories < ActiveRecord::Migration
   def up
	  	create_table 'users_categories', :id => false do |t|
		    t.column :user_id, :integer
		    t.column :category_id, :integer
		end  
   end
end
