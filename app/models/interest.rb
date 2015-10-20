class Interest < ActiveRecord::Base
	require 'will_paginate/array'
	include ApplicationHelper
	mount_uploader :image, AvatarUploader
	mount_uploader :icon, IconUploader
	mount_uploader :banner, BannerUploader
	belongs_to :category
	has_many :events ,dependent: :destroy
	has_many :questions ,dependent: :destroy
	has_many :special_messages ,dependent: :destroy
	has_and_belongs_to_many :users , :join_table => "users_interests" 
	before_destroy :delete_interest_users
	validates_presence_of  :image,:icon,:banner


	def delete_interest_users
		@users = self.users
		@users.update_all(:active_interest => nil)
		@action = self.users - @users
	end

	def self.view_matches_algo selected_interest, user, page, size
		matches = []
		@final = []
		@blok = blocked_user_list(user) + [user.id] + user_friends(user)
		if user.search_gender == "both"
			selected_interest.includes(users: [:profile,:cities]).where("users.id NOT IN (?) and users.current_city = ?",@blok.uniq,user.current_city).references(:users).each do |interest|
				matches << interest.users
			end
		elsif user.search_gender == "male"
			selected_interest.includes(users: [:profile,:cities]).where("users.id NOT IN (?) and users.current_city = ? and gender = ?",@blok.uniq,user.current_city, "male").references(:users).each do |interest|
				matches << interest.users
			end
		else
			selected_interest.includes(users: [:profile,:cities]).where("users.id NOT IN (?) and users.current_city = ? and gender = ?",@blok.uniq,user.current_city, "female").references(:users).each do |interest|
				matches << interest.users
			end
		end
			
		matches = matches.flatten
		@matchups = matches.uniq.paginate(:page => page, :per_page => size)
		@mact = {}
		@mact[:page] = page
		@mact[:per_page] = size
		@mact[:max_page] = @matchups.total_pages
		@mact[:total_entries] = @matchups.total_entries
		@matchups.each do |t|
			@intr = {}
			@int_arr = []
			(t.interests&user.interests).each do |i|
				@list_interest = {}
				@list_interest[:image] = i.icon.url 
				@list_interest[:color] = i.color
				@int_arr << @list_interest
			end  
			@intr[:profile] = t.profile.attributes.merge!(:online_status => t.online, points: point_algo(t,user), :common_interest=> @int_arr, :common_interest_count=> @int_arr.count)
			@final << @intr
		end
		return @final, @mact
	end


	def self.user_friends user
		acc = user.invitations.pluck(:reciever)
		snd = Invitation.where("reciever = ?", user.id).pluck(:user_id)
		(acc + snd).uniq
	end

	# def self.view_matches_algo selected_interest, user, page, size
	# 	@matches = []
	# 	@final = []
	# 	@blok = blocked_user_list(user) + [user.id]
	# 	selected_interest.each do |interest|
	# 		@int = {}
	# 		@int[:id] =  interest.id
	# 		@int[:interest_name] =  interest.interest_name
	# 		@int[:image] =  interest.image.url
	# 		@int[:icon] =  interest.icon.url
	# 		@int[:banner]= interest.banner.url
	# 		@int[:description] = interest.description
	# 		@int[:color] = interest.color
	# 		interest.users.where('id NOT IN (?)',@blok).each do |match|
	# 			@intr = {}
	# 			@int_arr = []
	# 			(match.interests&user.interests).each do |i|
	# 				@list_interest = {}
	# 				@list_interest[:image] = i.icon.url 
	# 				@list_interest[:color] = i.color
	# 				@int_arr << @list_interest
	# 			end  
	# 			@matches << match.profile.attributes.merge!(:online_status => match.online, points: point_algo(match.id,user.id), :common_interest => @int_arr ) if match.current_city == user.current_city
	# 		end
	# 		@final << @int.merge!(:users => @matches, :events => predefined_events(user, interest) )
	# 	end
	# 	return @final
	# end

end
