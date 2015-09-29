class LikesController < ApplicationController
	
	before_filter :check_user
	def like_event
		@event = Event.find_by_id(params[:event_id])
			if @user && @event
					if @like = Like.find_by(user_id: @user.id, event_id: @event.id).present?

							if @like = Like.find_by(user_id: @user.id, event_id: @event.id, status: false)
								@like.update_attributes(:status => true)
								@count = @event.likes.where(status: true).count
								render :json => {
																:response_code => 200,
																:status => @like.status,
																:count => @count,
																:message => "LIKE."
																}
							else	
								@like = Like.find_by(user_id: @user.id, event_id: @event.id, status: true)		
								@like.update_attributes(:status => false)
								@count = @event.likes.where(status: true).count
								render :json => {
																:response_code => 200,
																:status => @like.status,
																:count => @count,
																:message => "UNLIKE ."
																}
							end
					else
							@like = @user.likes.build(:user_id => params[:user_id], :event_id => params[:event_id], :status => params[:status] )
							@like.save
							@count = @event.likes.where(status: true).count
							render :json => {
															:response_code => 200,
															:status => @like.status,
															:count => @count,
															:message => "Like created."
															}
					end
			else
				render :json => {
												:response_code => 500,
												:message => "Something went wrong. "
												}
			end
	end

end
