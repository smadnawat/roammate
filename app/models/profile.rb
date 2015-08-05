class Profile < ActiveRecord::Base
  #mount_uploader :image, AvatarUploader
  belongs_to :user
 
  def self.import(file)
  	i=1
  	@status = ""
  	if File.extname(file.original_filename) == ".csv"
	  	CSV.foreach(file.path) do |row|
	  		if i!=1
	  			if row[12] == "new" or row[12] == "New"
	  				if !Profile.exists?(:email => row[1])
		  				email = row[1].split("@")
		  				@user = User.create(provider: email[1].split(".")[0],user_id: email[0])
		  				@profile = Profile.create(user_id: @user.id,email: row[1],first_name: row[2],last_name: row[3],image: row[4],location: row[5],gender: row[6],status: row[7],created_at: row[8],updated_at: row[9],dob: row[10],fb_email: row[11] ) 
		  				@status = "y"
	  				end
	  			elsif row[12] == "update" or row[12] == "Update"
	  				@pro = Profile.find_by_email(row[1])
	  				if @pro.update_attributes(first_name: row[2],last_name: row[3],image: row[4],location: row[5],gender: row[6],status: row[7],created_at: row[8],updated_at: row[9],dob: row[10],fb_email: row[11])
	  				 	@status = "y"
	  				else
	  					@status = "#{row[1]} not found"
	  					break	  					
	  				end
	  			elsif row[12] == "delete" or row[12] == "Delete"
	  				 if @pro = Profile.find_by_email(row[1])
	  					@pro.user.destroy
	  					@status = "y"
	  				else
	  					@status = "#{row[1]} not found"
	  					break
	  				end
	  			else
	  				@status = "y"
	  			end
	  		else
	  			i+=1
	  		end
	  	end
 	else
  		@status = "Please provide a valid csv file"
  	end
  	@status
  end

end
