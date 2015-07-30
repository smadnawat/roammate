class ProfilesController < ApplicationController
 before_filter :check_user  ,only: [:get_profile]

	def profile_status
		@profile = Profile.find(params[:id])
		@profile.status ? @profile.update_attributes(:status => false) : @profile.update_attributes(:status => true)
		redirect_to admin_profiles_path
	end


	def get_profile
		@profile = @user.profile		
	 	render :json => { :response_code => 200, :response_message => "Profile fetched",:profile => @profile.as_json(except: [:created_at,:updated_at]) 	}
	end

end
