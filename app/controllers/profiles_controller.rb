class ProfilesController < ApplicationController
 
 include ApplicationHelper
 before_filter :check_user  ,only: [:view_matched_profile, :add_profile_picture,:update_profile]

   
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
			@group = Group.where("(group_admin = ?  and group_name = ?) or (group_admin = ?  and group_name = ?)",@user.id,@member.id.to_s,@member.id,@user.id.to_s ).first
			@ratings = nil
			@ratable = false
			if @group.present?
				@ratings = @member.ratings.where(rater_id: @user.id).first.rate
				@ratable = message_count(@user,@group)
			end
			render :json => {
											:response_code => 200, :message => "record successfully fetched",
											:member_profile => @member.profile,
											:mutual_interests => @interests,
											:mutual_interests_count => @interests.count,
											:mutual_friends => @common_friends,
											:mutual_friends_count => @mutual_friends.count,
											:points => @points,
											:rate => @ratings,
											:can_rate => @ratable,
											}
		else
			render :json => {
											:response_code => 500,
											:message => "Something went wrong."
											}
		end
	end

	def update_profile
		@user.profile.first_name = params[:first_name] if params[:first_name].present?
		@user.profile.last_name = params[:last_name] if params[:last_name].present?
		@user.profile.dob = params[:dob] if params[:dob].present?
		@user.profile.fb_email = params[:fb_email]	if params[:fb_email].present?
		# params[:image] = Profile.image_data(params[:image])
		# if !@user.profile.image.present?
		# 	@user.profile.image = params[:image] if params[:image].present?
		# else
		# 	@user.albums.create(:image => params[:image], status: false)
		# end
		if @user.profile.save
			render :json => {:response_code => 200,:message => "Successfully updated profile"}
		else
			render :json => {:response_code => 500,:message => "Something went wrong."}
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
