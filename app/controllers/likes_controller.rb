class LikesController < ApplicationController
	
	before_filter :check_user
	def like_event
		@event = Event.find_by_id(params[:event_id])
		if (@user && @event)
			@count = @event.likes.where(status: true).count
			if @like = Like.find_by(user_id: @user.id, event_id: @event.id)
				if (@like.status == false)
					@like.update_attributes(:status => true)
					code = 200
					message = "Like created successfully"
				else	
					@like.update_attributes(:status => false)
					code = 200
					message = "UnLike created successfully"
				end
				render :json => {
								:response_code => code,
								:status => @like.status,
								:count => Like.where("event_id =? and status =?", @event.id, true).count,
								:message => message
								}
			else
					@like = @user.likes.build(:user_id => params[:user_id], :event_id => params[:event_id], :status => true )
					@like.save
					code = 200
					message = "Like created successfully"
					render :json => {
									:response_code => code,
									:status => @like.status,
									:count => Like.where("event_id =? and status =?", @event.id, true).count,
									:message => message
									}
			end
		else
			render :json => {
							:response_code => 500,
							:message => "Something went wrong"
							}
		end
	end

end

