class ProfilesController < ApplicationController
 
 include ApplicationHelper
 before_filter :check_user , only: [:get_profile_picture, :view_matched_profile, :add_profile_picture,:update_profile, :my_profile]

   
	def profile_status
		@profile = Profile.find(params[:id])
		@profile.status ? [@profile.update_attributes(:status => false), @profile.user.update_attributes(online: false)] : [@profile.update_attributes(:status => true), @profile.user.update_attributes(online: true)]
		redirect_to admin_profiles_path
	end

	def report_status
		@profile = Profile.find(params[:id])
		@profile.status ? [@profile.update_attributes(:status => false), @profile.user.update_attributes(online: false)] : [@profile.update_attributes(:status => true), @profile.user.update_attributes(online: true)]
		redirect_to admin_reports_path
	end

	def view_matched_profile
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			@points = point_algo(@user,@member)
			@mutual_friends = common_friends(@user.id, @member.id)
			@common_friends = Profile.where('id IN (?)', @mutual_friends)
			@group = Group.where("(group_admin = ?  and group_name = ?) or (group_admin = ?  and group_name = ?)",@user.id,@member.id.to_s,@member.id,@user.id.to_s ).first
			@ratings = nil
			@ratable = false
			@interests = common_activities(@user.id, @member.id)
			@is_friend = is_friend(@user.id,@member.id)
			@is_blocked = user_is_block?(@user.id, @member.id)
			@events = user_liked_events(@member)
			@rating = "#{user_rating(@member.id)}%"
			@positive_ratings_count = @member.ratings.where(:rate=>"1").count
			@n = "#{@rating} of #{@positive_ratings_count} positive rates"
			if @group.present?
				@ratable = message_count(@user,@group)
			end
			render :json => {
											:response_code => 200, :message => "record successfully fetched",
											:member_profile => @member.profile.attributes.merge(:last_active_at => @member.updated_at.to_i, :online_status => @member.online ),
											:friendship_status => @is_friend ? (@is_friend.status ? "Friend" : "Request sent") : "Not friend" ,
											:mutual_interests => @interests,
											:mutual_interests_count => @interests.count,
											:liked_events => @events,
											:liked_events_count => @events.count,
											:mutual_friends => @common_friends,
											:mutual_friends_count => @mutual_friends.count,
											:points => @points,
											:rate => @rating,
											:total_rating_users => @member.ratings.count,
											:positive_ratings_count => @positive_ratings_count,
											:msg => @n,
											:can_rate => @ratable,
											:is_blocked => @is_blocked
											}
		else
			render :json => {
											:response_code => 500,
											:message => "Member not present."
											}
		end
	end

	def my_profile
		@profile = @user.profile
		@points = user_points(@user,ServicePoint.all)
		@interests = @user.interests
		@events = user_liked_events(@user)
		@intr = []
		@interests.each do |i|
			@int = {}
			@int[:id] =  i.id
			@int[:interest_name] =  i.interest_name
			@int[:image] =  i.image.url
			@int[:icon] =  i.icon.url
			@int[:banner]= i.banner.url
			@int[:description] = i.description
			@int[:color] = i.color
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
		:profile => @profile.attributes.merge!(:user_current_city => @profile.user.current_city, :album => @user.albums.as_json(:only => [:image]), :liked_events => @events, :liked_events_count => @events.count, :my_points=> @points,:my_friends_count => @friends.count, :my_interest => @intr, :my_interest_count => @intr.count , :rate => @rating,:total_rating_users => @user.ratings.count,:positive_ratings_count => @positive_ratings_count,:msg => @n, :my_friends => @friends)}
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
		if params[:album].present?
			params[:album].each do |imgg|
				Album.find(imgg[:id]).update_attributes(image: imgg[:image])
			end
			@user.profile.update_attributes(image: params[:album].first )
			render :json => {:response_code => 200,:message => "Successfully uploaded images"}
		else
			render :json => {:response_code => 500,:message => "Images not present."}
		end
	end

	def get_profile_picture
		@user.albums.present? ? (render :json => {:response_code => 200,:message => "Successfully fetched profile",:album => @user.albums.order('created_at DESC').all.as_json(:only => [:image, :id]) }) : (render :json => {:response_code => 500,:message => "No record found" })
	end


end
