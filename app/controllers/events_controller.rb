class EventsController < ApplicationController

	def predefined_events
		@events = Event.all
		if @events.present?
			render :json => { :response_code => 200, :response_message => "Successfully fetched events.",
			:events => @events.as_json(except: [:created_at, :updated_at]) }
		else
			render :json => {:response_code => 500, :response_message => "No event found."}
		end
	end

end
