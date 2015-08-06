class ProfilesController < ApplicationController
 
 include ApplicationHelper
 before_filter :check_user  ,only: [:view_matched_profile, :add_profile_picture]

   
	def profile_status
		@profile = Profile.find(params[:id])
		@profile.status ? @profile.update_attributes(:status => false) : @profile.update_attributes(:status => true)
		redirect_to admin_profiles_path
	end


	def view_matched_profile
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			@interests = common_activities(@user.id, @member.id)
			@points = point_algo(@user.id,@member.id)
			@mutual_friends = common_friends(@user.id, @member.id)
			@common_friends = Profile.where('id IN (?)', @mutual_friends)
			render :json => {:response_code => 200, :message => "record successfully fetched",
											:member_profile => @member.profile,
											:mutual_interests => @interests,
											:mutual_interests_count => @interests.count,
											:mutual_friends => @common_friends,
											:mutual_friends_count => @mutual_friends.count,
											:points => @points
											}
		else
			render :json => {
											:response_code => 500,
											:message => "Something went wrong."
											}
		end
	end

	def add_profile_picture
		@image = @user.albums.build(image: params[:image], status: params[:status])
		if @image.save
			render :json => {:response_code => 200,:message => "Successfully changed porfile picture"}
		else
			render :json => {:response_code => 500,:message => "Something went wrong."}
		end
	end

end
