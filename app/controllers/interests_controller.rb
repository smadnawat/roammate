class InterestsController < ApplicationController

	include ApplicationHelper
	before_filter :check_user, :only => [:picked_interest_user_list, :selected_interest_list]


	def picked_interest_user_list
		@interest = Interest.where('id = ?',params[:interest_id])
		if @interest.present?
			@user.update_attributes(active_interest: params[:interest_id])
			@matches = Interest.view_matches_algo(@interest, @user)
			render :json => 
							{ 
							:response_code => 200, 
							:response_message => "Successfully fetched selected interests",
							:matches => @matches	
							}
		else
			render :json => 
							{ 
							:response_code => 500, 
							:response_message => "No record found"
							}
		end
	end

	def selected_interest_list
		if params[:interests].present?
			params[:interests].as_json(only: [:id]).each do |t|
 				if !@user.interests.include?(Interest.find(t.values).first)
					@user.interests << Interest.find(t.values)
				end
			end
		end
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
				@interest << @int
			end		
		@matches = Interest.view_matches_algo(@selected_interest, @user)
		if @selected_interest.present?
			render :json => { :response_code => 200, :response_message => "Successfully fetched selected interests",
		 	:selected_interest => @interest,
		  :matches => @matches	}
		else
			render :json => { :response_code => 500, :response_message => "No record found"}
		end
	end

	def predefined_interests
		@interests = Interest.all.paginate(:page => params[:page], :per_page => params[:size])
		if @interests.present?
			@interest = []
			@interests.each do |i|
				@int = {}
				@int[:id] =  i.id
				@int[:interest_name] =  i.interest_name
				@int[:image] =  i.image.url
				@int[:icon] =  i.icon.url
				@int[:banner]= i.banner.url
				@int[:description] = i.description
				@interest << @int
			end
			render :json => { :response_code => 200, :response_message => "Successfully fetched interests.",
			 :interests => @interest ,:paging => {:per_page => params[:size], :page => params[:page]} }
		else
			render :json => { :response_code => 500, :response_message => "Interests not found."}
		end
	end
	
end
