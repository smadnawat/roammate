class RatingsController < ApplicationController

	before_filter :check_user, :only => [:new_user_rating]

	def new_user_rating
		@member = User.find_by_id(params[:member_id])
		@group = Group.where("(group_admin = ?  and group_name = ?) or (group_admin = ?  and group_name = ?)",@user.id,@member.id.to_s,@member.id,@user.id.to_s ).first
		if @group.present?
			p "++++++++++++++++After group present++++++++++++++++++"
			if @group.users.count < 3 and @member.present?	and  message_count(@user, @group)
				 if @member.ratings.where("rater_id = ?",@user.id).count < 1
				 	p "++++++++++++++++Under if++++++++++++++++++"
					@ratings = @member.ratings.create(rate:  params[:rate], rater_id: @user.id, reason: params[:reason])
					@user.points.create(:pointable_type => "Rate Roammate")
				 else
				 	p "++++++++++++++++Under else++++++++++++++++++"
				 	@ratings = @member.ratings.where(rater_id: @user.id).first.update_attributes(rate: params[:rate])
				 end				
					render :json => {
													:response_code => 200,
													:message => "Ratings created successfully.", 
													:rating => params[:rate]
													}
			else
					render :json => {
													:response_code => 500,
													:message => "You have to sent and recieve atleast 10 messages."
													}
			end
		else
				render :json => {
												:response_code => 500,
												:message => "Group not found"
												}
		end
	end

end
