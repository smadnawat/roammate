class UsersController < ApplicationController

	def destroy_users
		@user = User.find(params[:id])
		@rates = Rating.where("rater_id = ?", @user.id)
		@rates.destroy_all
		@user.destroy
		redirect_to admin_profiles_path
	end

	def login	
	  @user = nil
	  @profile = nil
	  @status = false
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
 		@user = User.create(user_id: params[:user_id], provider: params[:provider],authentication_token: params[:auth_token])
		@profile = Profile.create(email: "#{params[:user_id]}@#{params[:provider]}.com", fb_email: params[:email],first_name: params[:first_name], image: params[:image] ,last_name: params[:last_name], gender: params[:gender], status: false, user_id: @user.id,dob: params[:dob],location: params[:address])
	  	@signup_points = @user.points.create(:pointable_type => "signup")
	  	if @user and @profile
	  	   @status =true
	  	else
	  		@status =false
	  	end
	  end
	  if !Device.where("device_id =? and device_type= ?", params[:device_id],params[:device_type]).present?
	    @device = @user.devices.create(:device_id => params[:device_id],:device_type =>params[:device_type]) 
	  end
	 if @status
	 	render :json => { :response_code => 200, :response_message => "Successfull login",:profile => @profile.as_json(except: [:created_at,:updated_at]) 	}
	 else
		render :json => { :response_code => 500, :response_message => "Login failed" }
	 end
	end

	def catch_404
   	 render nothing: true
  	end


end
