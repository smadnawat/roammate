class Profile < ActiveRecord::Base
  #mount_uploader :image, AvatarUploader
  belongs_to :user
  has_many :points, as: :pointable, dependent: :destroy

  def self.import(file)
  	i=1
  	@status = false
  	if File.extname(file.original_filename) == ".csv"
	  	CSV.foreach(file.path) do |row|
	  		if i!=1
	  			if Profile.exists?(:email => row[1])
	  				@pro = Profile.find_by_email(row[1])
	  				if @pro.update_attributes(first_name: row[2],last_name: row[3],image: row[4],location: row[5],gender: row[6],status: row[7],locale: row[8],timezone: row[9],created_at: row[10],updated_at: row[11],dob: row[12])
	  				 	@status = true
	  				else
	  					@status = false
	  				end
	  			else
	  				email = row[1].split("@")
	  				@user = User.create(provider: email[1].split(".")[0],user_id: email[0])
	  				@profile = Profile.create(user_id: @user.id,email: row[1],first_name: row[2],last_name: row[3],image: row[4],location: row[5],gender: row[6],status: row[7],locale: row[8],timezone: row[9],created_at: row[10],updated_at: row[11],dob: row[12]) 
	  				@status = true
	  			end
	  		else
	  			i+=1
	  		end
	  	end
	  else
	  	@status = false
	  end
  	@status
  end

end
