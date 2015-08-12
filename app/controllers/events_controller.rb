class EventsController < ApplicationController

	def predefined_events
		@events = Event.all
		@event = []
		if @events.present?
			@events.each do |e|
				@eve = {}
				@eve[:id] = e.id
				@eve[:event_name] = e.event_name
				@eve[:place] = e.place
				@eve[:link] = e.link
				@eve[:city] = e.city
				@eve[:event_time] = e.event_time
				@eve[:event_date] = e.event_date
				@eve[:host_name] = e.host_name
				@eve[:image] = e.image.url
				@event << @eve
			end
			render :json => { :response_code => 200, :response_message => "Successfully fetched events.",
			:events => @event }
		else
			render :json => {:response_code => 500, :response_message => "No event found."}
		end
	end

end
