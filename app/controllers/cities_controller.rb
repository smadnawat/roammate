class CitiesController < ApplicationController
 before_filter :check_user  

	def add_current_city
		if (params[:current_city] and params[:country]).present?
		 	@user_city = nil
		 	if !City.exists?(:city_name => params[:current_city].strip)
		  	@user_city = City.create(:city_name => params[:current_city].strip, :state => params[:state].strip, :country => params[:country].strip, :status => true)
		  	@user.points.create(:pointable_type => "Add New City")
		 		@user.cities << @user_city if !@user.cities.exists?(@user_city)
		  else
		  	@user_city = City.find_by_city_name(params[:current_city].strip)
		  	@user.cities << @user_city if !@user.cities.exists?(@user_city)
		 	end
 		  render :json => { :response_code => 200, :response_message => "#{@user_city.city_name} is added to current city" ,:current_city => @user.current_city 	}
		else			
   	 	render :json => { :response_code => 500, :response_message => "Invalid or inappropriate data."}
		end
	end

	def get_user_cities
		@user_cities = @user.cities.paginate(:page => params[:page], :per_page => params[:size])
		@max = @user_cities.total_pages
		@total_entries = @user_cities.total_entries
		render :json => { :response_code => 200, :response_message => "All cities of user" ,:cities => @user_cities.as_json(only: [:id,:city_name]), :pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries}	}
	end

	def add_user_current_city_status
		@city = City.find_by_id(params[:city_id])
		@user.update_attributes(current_city: @city.city_name) if @city.present?
		render :json => { :response_code => 200, :response_message => "#{@city.city_name} has been added" }
	end

	def remove_city
	  @city = City.find_by_id(params[:city_id])
	  @user.cities -= [@city]
	  render :json => { :response_code => 200, :response_message => "#{@city.city_name} has been removed" ,:cities => @user_cities.as_json(only: [:id,:city_name])	}
	end

end
