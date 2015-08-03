class ProfilesController < ApplicationController
 before_filter :check_user  ,only: [:view_matched_profile]

	def profile_status
		@profile = Profile.find(params[:id])
		@profile.status ? @profile.update_attributes(:status => false) : @profile.update_attributes(:status => true)
		redirect_to admin_profiles_path
	end


	# def view_matched_profile
	# 	@member = User.find_by_id(params[:member_id])
	# 	if @member.present?
	# 		@common
	# 	else

	# 	end
	# end

	def select_user_to_add
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			@current_user_interests = @user.interests
			@member_interests = @member.interests
			
			@mutual_interests = @current_user_interests&@member_interests
			@member_profile = @member.profile

			@mutual_friends = Invitation.where("user_id = ? or reciever = ? ", @user , @user)

				render :json => {
					:response_code => 200,
					:message => "record successfully fetched",
					:member_profile => @member_profile,
					:mutual_interests => @mutual_interests,
					:mutual_friends => @mutual_friends
				}
			
				else
					render :json => {
					:message => "Something went wrong."
				}
		end		
	end



end
