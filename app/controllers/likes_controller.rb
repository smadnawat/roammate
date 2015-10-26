class LikesController < ApplicationController
	
	before_filter :check_user

	def like_event
		event = Event.includes(:likes).find_by_id(params[:event_id])
		if event.present?
			event = Event.like_on_event(event, @user)
			render :json => {:response_code => 200,	:count => event,:message => "Successfully updated status"	}
		else
			render :json => { :response_code => 500 ,:message => "Event not found."	}
		end
	end

end

