class EventsController < ApplicationController

	before_filter :check_user, only: [:get_predefined_events]
	
	def get_predefined_events
		if @inttr = Interest.find_by_id(params[:interest_id])
			@events = predefined_events(@user, @inttr)
			render :json => { :response_code => 200,:response_message => "Successfully fetched events.",:events => @events}
		else
			render :json => { :response_code => 500,:response_message => "Somethig went wrong." }
		end
	end

	def click_on_event_link
		if @event = Event.find_by_id(params[:event_id])
			@event.click_count = (@event.click_count + 1.0)
			@event.save
			render :json => { :response_code => 200,:response_message => "Successful"}
		else
			render :json => { :response_code => 500,:response_message => "Unsuccessful" }
		end
	end

end
