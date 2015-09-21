class EventsController < ApplicationController


	def get_predefined_events
		@events = predefined_events
		p "++++++++++++#{@events.inspect}+++++++++++++++++++++"
		# if @events.present?	
			render :json => { :response_code => 200,:response_message => "Successfully fetched events.",:events => @events}
		# else
		# 	render :json => { :response_code => 200,:response_message => "Successfully fetched events."
		# end
	end

end
