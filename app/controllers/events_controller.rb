class EventsController < ApplicationController

	before_filter :check_user, only: [:get_predefined_events]
	
	def get_predefined_events
		@events = predefined_events(@user)
		render :json => { :response_code => 200,:response_message => "Successfully fetched events.",:events => @events}
	end

end
