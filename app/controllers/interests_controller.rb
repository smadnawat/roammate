class InterestsController < ApplicationController

	before_filter :check_user, :only => [:find_mutual_interest, :selected_interest_list, :current_city, :filter_user_selected_interest,:get_interests]

	def predefined_interests
		@interests = Interest.all
		render :json => { :response_code => 200, :response_message => "Successfully fetched interests",
		 :interests => @interests.as_json(except: [:created_at, :updated_at, :category_id]) }
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
		if @selected_interest.present?
			render :json => { :response_code => 200, :response_message => "Successfully fetched selected interests",
		 :selected_interest => @selected_interest.as_json(except: [:created_at,:updated_at]) 	}
		else
			render :json => { :response_code => 500, :response_message => "No record found"}
		end
	end

	def find_mutual_interest
		@current_user_interests = @user.interests
		@visitor_user = User.find_by_id(params[:member_id])
		@visitor_user_interests = @visitor_user.interests
		@mutual_interests = @current_user_interests&@visitor_user_interests
		if @mutual_interests.present?
			render :json => { :response_code => 200, :response_message => "Mutual Interests fetched successfully",
		 :mutual_interests => @mutual_interests.as_json(except: [:created_at,:updated_at]) 	}
		else
			render :json => { :response_code => 500, :response_message => "No record found"}
		end
	end

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

	def filter_user_selected_interest
		@interest = Interest.find_by_id(params[:interest_id])
		@interest_users = @interest.users
		if @interest_users.present?
		arr = []
				@interest_users.each do |user|
					if user.profile.current_city == params[:city].strip
						arr << user.profile
					end
				end
				message = "successfully fetched users"
				code = 200
		else
				message = "No record found."	
				code = 500
		end
		render :json => { :response_code => code, :response_message => message, :users => arr }
	end

	def get_interests
		@interests = @user.interests
		render :json => { :response_code => 500, :response_message => "Interests found", :interests => @interests }
	end

end
