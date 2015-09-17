class ProfilesController < ApplicationController
 
 include ApplicationHelper
 before_filter :check_user  ,only: [:view_matched_profile, :add_profile_picture,:update_profile, :my_profile]

   
	def profile_status
		@profile = Profile.find(params[:id])
		@profile.status ? @profile.update_attributes(:status => false) : @profile.update_attributes(:status => true)
		redirect_to admin_profiles_path
	end


	def view_matched_profile
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			@points = point_algo(@user.id,@member.id)
			@mutual_friends = common_friends(@user.id, @member.id)
			@common_friends = Profile.where('id IN (?)', @mutual_friends)
			@group = Group.where("(group_admin = ?  and group_name = ?) or (group_admin = ?  and group_name = ?)",@user.id,@member.id.to_s,@member.id,@user.id.to_s ).first
			@ratings = nil
			@ratable = false
			@interests = common_activities(@user.id, @member.id)
			@is_friend = is_friend(@user.id,@member.id)
			@rating = "#{user_rating(@member.id)}%"
			@positive_ratings_count = @member.ratings.where(:rate=>"1").count
			@n = "#{@rating} of #{@positive_ratings_count} positive rates"
			if @group.present?
				@ratable = message_count(@user,@group)
			end
			render :json => {
											:response_code => 200, :message => "record successfully fetched",
											:member_profile => @member.profile.attributes.merge(:last_active_at => @member.updated_at.to_date),
											:friendship_status => @is_friend ? (@is_friend.status ? "Friend" : "Request sent") : "Not friend" ,
											:mutual_interests => @interests,
											:mutual_interests_count => @interests.count,
											:mutual_friends => @common_friends,
											:mutual_friends_count => @mutual_friends.count,
											:points => @points,
											:rate => @rating,
											:total_rating_users => @member.ratings.count,
											:positive_ratings_count => @positive_ratings_count,
											:msg => @n,
											:can_rate => @ratable,
											}
		else
			render :json => {
											:response_code => 500,
											:message => "Something went wrong."
											}
		end
	end

	def my_profile
		@profile = @user.profile
		@points = user_points(@user.id)
		@interests = @user.interests
		@intr = []
		@interests.each do |i|
			@int = {}
			@int[:id] =  i.id
			@int[:interest_name] =  i.interest_name
			@int[:image] =  i.image.url
			@int[:icon] =  i.icon.url
			@int[:banner]= i.banner.url
			@int[:description] = i.description
			@intr << @int
		end
		@recieve = Invitation.where('reciever = ? and status = ?', @user.id, true).pluck(:user_id)
		@send = Invitation.where('user_id = ? and status = ?', @user.id, true).pluck(:reciever)
		@all_invites = @recieve + @send
		@friends = [] 
		@all_invites.each do |user|
			@friends << User.find(user).profile
		end
		@rating = "#{user_rating(@user.id)}%"
		@positive_ratings_count = @user.ratings.where(:rate=>"1").count
		@n = "#{@rating} of #{@positive_ratings_count} positive rates"

		render :json => {:response_code => 200,:message => "Successfully fetched profile",
		:profile => @profile.attributes.merge!(:my_points=> @points,:my_friends_count => @friends.count, :my_interest => @intr, :my_interest_count => @intr.count , :rate => @rating,:total_rating_users => @user.ratings.count,:positive_ratings_count => @positive_ratings_count,:msg => @n, :my_friends => @friends)}
	end

	def update_profile
		@user.profile.first_name = params[:first_name] if params[:first_name].present?
		@user.profile.last_name = params[:last_name] if params[:last_name].present?
		@user.profile.dob = params[:dob] if params[:dob].present?
		@user.profile.fb_email = params[:fb_email]	if params[:fb_email].present?
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
