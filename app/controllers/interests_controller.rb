class InterestsController < ApplicationController

	require 'will_paginate/array'
	include ApplicationHelper
	before_filter :check_user, :only => [:picked_interest_user_list, :predefined_interests, :selected_interest_list, :pre_selected_interests]

	def picked_interest_user_list
		@interest = Interest.where('id = ?',params[:interest_id])
		if @interest.present?
			@user.update_attributes(active_interest: @interest.first.id)
			@matches = Interest.view_matches_algo(@interest, @user, params[:page],params[:size])
			p "++++++++++++#{@matches.inspect}+++++++++++++++++++"
			# @max = @matches.total_pages
			# @total_entries = @matches.total_entries
			render :json => 
							{ 
							:response_code => 200, 
							:response_message => "Successfully fetched selected interests",
							:matches => @matches,
							:pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries}
							}
		else
			render :json => 
							{ 
							:response_code => 500, 
							:response_message => "No record found"
							}
		end
	end

	def pre_selected_interests
		@selected_interest = @user.interests
		@interest = []
		@selected_interest.each do |i|
			@int = {}
			@int[:id] =  i.id
			@int[:interest_name] =  i.interest_name
			@int[:image] =  i.image.url
			@int[:icon] =  i.icon.url
			@int[:banner]= i.banner.url
			@int[:description] = i.description
			@int[:color] = i.color
			@interest << @int
		end		
		render :json => 
							{ 
							:response_code => 200, 
							:response_message => "Pre-selected interests",
							:pre_selected_interests => @interest
							}
	end

	def selected_interest_list
		p ".........params--------#{params.inspect}--------"
		@now_selected = params[:interests]
		@pre_selected = @user.interests.pluck(:id)
		@common = @now_selected&@pre_selected
		# if @common.present?
			@add = @now_selected-(@now_selected&@pre_selected) #if @common.present?
			p "-----add-----#{@add}"
			@rmv = @pre_selected-(@now_selected&@pre_selected) #if @common.present?
			p "------rmv----#{@rmv}"
		# else
		# 	@add = params[:interests]

		# end
		 if @add.present?
			@add.each do |t|
				@a=Interest.find_by_id(t)
 				if !@user.interests.include?(@a)
					@user.interests << @a if @a.present?
				end
			end
			p "-----after---added------#{@user.interests.pluck(:id)}"
		 end
		 p "+++++++++++++++@rmv = @pre_selected-(@now_selected&@pre_selected)+++++++++++++++++++++"
		 if @rmv.present?
		 	@rmv.each do |r|
		 		@user.interests.delete(r)
		 	end
		 	p "------finally---after-- rmv ----#{@user.interests.pluck(:id)}"
		 end
		@selected_interest = @user.interests
		p "---selected------#{@selected_interest.pluck(:id)}"
		@interest = []
		@selected_interest.each do |i|
			@int = {}
			@int[:id] =  i.id
			@int[:interest_name] =  i.interest_name
			@int[:image] =  i.image.url
			@int[:icon] =  i.icon.url
			@int[:banner]= i.banner.url
			@int[:description] = i.description
			@int[:color] = i.color
			@interest << @int
		end		
		p "------------interest----#{@interest.inspect}"
		# p "=======matches===#{@matches.inspect}"
		@matches = Interest.view_matches_algo(@selected_interest, @user, params[:page],params[:size])	
		# @max = @matches.total_pages
		# @total_entries = @matches.total_entries
		@events = predefined_events(@user)
		# p "++++++++++++@matches++++++++#{@matches}++++++++++++++++++++++"
			render :json => { 
			:response_code => 200, :response_message => "Successfully fetched selected interests",
		 	:selected_interest => @interest,
			:matches => @matches,
			:events => @events,
			:pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries}
			}
	end

	def predefined_interests
		@user_int = @user.interests.pluck(:id)
	  @user_int.present? ? @interests = Interest.where("id NOT IN (?)",@user_int).all.paginate(:page => params[:page], :per_page => params[:size]) :  @interests = Interest.all.paginate(:page => params[:page], :per_page => params[:size])
		@max = @interests.total_pages.to_s
		@total = @interests.total_entries.to_s
		@per = @interests.per_page.to_s
		if @interests.present?
			@interest = []
			@interests.each do |i|
				@int = {}
				@int[:id] =  i.id
				@int[:interest_name] =  i.interest_name
				@int[:image] =  i.image.url
				@int[:icon] =  i.icon.url
				@int[:banner]= i.banner.url
				@int[:color]= i.color
				@int[:description] = i.description
				@interest << @int
			end
			render :json => { :response_code => 200, :response_message => "Successfully fetched interests.",
			 :interests => @interest ,:paging => {:max_page=> @max,:total_entries=> @total,:per_page => @per, :page => params[:page]} }
		else
			render :json => { :response_code => 500, :response_message => "Interests not found."}
		end
	end
	
end
