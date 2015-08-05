class RatingsController < ApplicationController

	before_filter :check_user, :only => [:new_user_rating, :user_rerating]

	def new_user_rating
		@member = User.find_by_id(params[:member_id])
		if @member.present?
			if message_count(@user.id, @member.id)
				@ratings = @user.ratings.create(rate: params[:rate], rater_id: @member.id, reason: params[:reason])
				@user.points.create(:pointable_type => "Rate Roammate")
				message = "Ratings created successfully."
				code =  200
			else
				message = "You have to sent and recieve atleast 15 messages."
				code =  400
				@ratings = nil
			end
			render :json => {
											:response_code => code,
											:message => message, 
											:rating => @ratings
											}
		else
			render :json => {
											:response_code => 500,
											:message => "Something went wrong."
											}
		end
	end

	def update_user_rating
		@rating = Rating.find_by_id_and_user_id(params[:rating_id], @user.id)
		if @rating.present?
			@rating.update_attributes(rate: params[:rate], reason: params[:reason])
			render :json => {
												:response_code => 200,
												:message => "successfully updated"
											}
		else
			render :json => {
											:response_code => 500,
											:message => "Something went wrong."
											}
		end
	end

end
