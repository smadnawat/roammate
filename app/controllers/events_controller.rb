class EventsController < ApplicationController

	def predefined_events
		@events = Event.all
		render :json => { :response_code => 200, :response_message => "Successfully fetched events",
		:events => @events.as_json(except: [:created_at, :updated_at]) }
	end

end
