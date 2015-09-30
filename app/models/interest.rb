class Interest < ActiveRecord::Base
	require 'will_paginate/array'
	include ApplicationHelper
	mount_uploader :image, AvatarUploader
	mount_uploader :icon, IconUploader
	mount_uploader :banner, AvatarUploader
	belongs_to :category
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
			@blok = blocked_user_list(user) + [user.id]
			selected_interest.each do |interest|
				interest.users.where('id NOT IN (?)',@blok).each do |match|
					matches << match if match.current_city == user.current_city
				end
			end
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
				@intr[:profile] = t.profile.attributes.merge!(points: point_algo(t.id,user.id), :common_interest=> @int_arr)
				@final << @intr
			end
			return @final, @mact
			 # @final.append(:pagination => @mact)

	end

end
