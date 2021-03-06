class UsersController < ApplicationController
	before_filter :check_user, :only => [:online_offline]

	def destroy_users
		@user = User.find(params[:id])
		@rates = Rating.where("rater_id = ?", @user.id)
		@rates.destroy_all
		@invitations = Invitation.where("reciever = ?",@user.id)
		@invitations.destroy_all
		@notification = Notification.where("reciever = ?",@user.id)
		@notification.destroy_all
		@group = Group.where("group_admin = ?",@user.id)
		@group.destroy_all
		@block = Block.where("member_id = ?", @user.id)
		@block.destroy_all
		@report = Report.where("member_id = ?", @user.id)
		@report.destroy_all
		@user.destroy
		redirect_to admin_profiles_path
	end


	def login
	  @user = nil
	  @profile = nil
	  @status = false
	  @geo_api_msg = false
	  if params[:user_id].present?	   	  
		  if User.exists? user_id: params[:user_id]
		  	@user = User.find_by_user_id(params[:user_id])	
		  	@profile = @user.profile
		  	@user.authentication_token = params[:auth_token] if params[:auth_token].present?
		  	@profile.first_name = params[:first_name] if params[:first_name].present?
		  	@profile.last_name = params[:last_name] if params[:last_name].present?
		    @profile.dob = params[:dob] if params[:dob].present?
		    @profile.fb_email = params[:email] if params[:email].present?
		    @profile.location = params[:address] if params[:address].present?
		    @profile.email = "#{params[:user_id]}@#{params[:provider]}.com"
		    @profile.image = params[:image] if params[:image].present?
		    @profile.gender = params[:gender] if params[:gender].present?
		    if @profile.save and @user.save
	          @status =true
		    else
		       @status =false
		    end
		  else		  
	 		@user = User.create(user_id: params[:user_id], provider: params[:provider],authentication_token: params[:auth_token], search_gender: "both")
			@profile = Profile.create(email: "#{params[:user_id]}@#{params[:provider]}.com", fb_email: params[:email],first_name: params[:first_name], image: params[:image] ,last_name: params[:last_name], gender: params[:gender], status: true, user_id: @user.id,dob: params[:dob],location: params[:address])
		  	@signup_points = @user.points.create(:pointable_type => "Sign Up")
		  	@album = params[:album]
		  	@admin_user_group = Group.create(group_name: "Team Roammate", group_admin: @user.id)
		  	@user.groups << @admin_user_group
		  	@album.map{|x| @user.albums.create(image: x, status: false)}
		  	if @user and @profile
		  	   @status =true
		  	else
		  		@status =false
		  	end			 
		  end

      if ( params[:city].present? and params[:state].present? and params[:country].present? )
    	  @add_current_location = @user.update_attributes(:latitude=> params[:latitude],:longitude => params[:longitude],:current_city => params[:city])     
			  if !City.exists?(:city_name => params[:city].strip , :state=> params[:state].strip, :country=> params[:country].strip)
			  	@user_city = @user.cities.create(:city_name => params[:city].strip,:state => params[:state].strip,:country => params[:country].strip,:status => true)
			  else
			  	@user_city = City.find_by_city_name(params[:city].strip)
			  	@user.cities << @user_city if !@user.cities.exists?(@user_city)
			  end
			else
			 	@geo_api_msg = "Please provide city,state,country all these are mendatory."
			 	@status =false
			end

			# @album = [params[:image], "http://res.cloudinary.com/dklf0amce/image/upload/v1444192617/hun0lyh1ic2turqy2dag.png", "http://res.cloudinary.com/dklf0amce/image/upload/v1444192644/wkzmh7ulcaf4fmkvzgkt.png"]
		  # @user.albums.first.update_attributes(image: params[:image]) if !@user.albums.find_by_image(params[:image])
		  # @album.map{|x| @user.albums.create(image: x, status: false)}

		  if !Device.where("device_id =? and device_type= ? and user_id = ?", params[:device_id],params[:device_type],@user.id).present?
		    Device.where("device_id =? and device_type= ?", params[:device_id],params[:device_type]).destroy_all
		    @device = @user.devices.create(:device_id => params[:device_id],:device_type =>params[:device_type].downcase) 
		  end
	  else
		 @status =false
	  end

	  if @status
	  	@points = user_points(@user, ServicePoint.all)
	  	@user.update_attributes(:created_at => Time.now,:online => true)
	  	render :json => { :response_code => 200, :response_message => "Successfull login",:profile => @profile.as_json(except: [:created_at,:updated_at]) ,:points => @points 	}
	  else
	  	if @geo_api_msg.present?
	  		render :json => { :response_code => 500, :response_message => "Login failed",  :missing => @geo_api_msg  }
	  	else
		  	render :json => { :response_code => 500, :response_message => "Login failed" }
     	end
	  end
	end


	def online_offline
		if (params[:status] == "true")
			@user.update_attributes(:online => true,:last_active_at => Time.now)
			msg = "Online"
		else
			@user.update_attributes(:online => false,:last_active_at => Time.now)
			msg = "Offline"
		end
		render :json => { :response_code => 200, :response_message => msg }
	end

	def catch_404
 	 render nothing: true
	end

end
