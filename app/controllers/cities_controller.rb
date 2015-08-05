class CitiesController < ApplicationController
 before_filter :check_user  

	def add_current_city
		if params[:current_city].present?
		  @user_city =nil
		  if !City.exists?(:city_name => params[:current_city].strip)
		  	@user_city = @user.cities.create(:city_name => params[:current_city].strip)
		  	@user.points.create(:pointable_type => "Add New City")
		  else
		  	@user_city = City.find_by_city_name(params[:current_city].strip)
		  	@user.cities << @user_city if !@user.cities.exists?(@user_city)
		  end
		  @current_city = @user.update_attributes(:current_city => params[:current_city].strip)
      render :json => { :response_code => 200, :response_message => "#{@user_city.city_name} is added to current city" ,:current_city => @user.current_city 	}
		else			
      render :json => { :response_code => 500, :response_message => "Something wrong"	}
		end
	end

	def get_user_cities
		@user_cities = @user.cities
		render :json => { :response_code => 200, :response_message => "All cities of user" ,:cities => @user_cities.as_json(only: [:id,:city_name])	}
	end

	def remove_city
		@city = City.find_by_city_name(params[:city_name].strip)
		@user.cities -= [@city]
	  render :json => { :response_code => 200, :response_message => "#{@city.city_name} has been removed" ,:cities => @user_cities.as_json(only: [:id,:city_name])	}
	end


end
