class PointsController < ApplicationController
  include ActionView::Helpers::DateHelper
  include ApplicationHelper
 before_filter :check_user 

	def get_point
  	  @points = @user.points
      @point_sum =0
      if @points.present?
         @points.each do |p|          
           @point = ServicePoint.find_by_service(p.pointable_type)
           @point_sum = @point_sum + @point.point
         end
      else
         @point_sum = 0
      end
      render :json => { :response_code => 200, :response_message => "Points of users" ,:points => @point_sum 	}
  end

  def point_algo
    @second_user = User.find(params[:user_id2])
    @distance = @user.distance_to([@second_user.latitude,@second_user.longitude],:km).round(2)
    @last_activity_hour = (Time.now - @second_user.updated_at)/3600
    @last_active_hour = @second_user.online ? -1 : (Time.now - @second_user.last_active_at)/3600
    @age_difference=0
    @user1_age =@user.profile.dob
    @user2_age =@second_user.profile.dob
    if !@user1_age.nil? and !@user2_age.nil?
       if @user1_age > @user2_age
         @age_difference = (@user1_age-@user2_age).to_i/365
       else
        @age_difference = (@user2_age-@user1_age).to_i/365
       end
    else
      @age_difference = 0
    end
    @user1_sex = @user.profile.gender
    @user2_sex =@second_user.profile.gender
    if @user1_sex != @user2_sex
      @gender_type = "different"
    else
      @gender_type = @user2_sex
    end
    @common_cities = @user.cities&@second_user.cities
    @user1_current_city = @user.current_city
    @user2_current_city = @second_user.current_city
    @user1_current_city == @user2_current_city ?  @same_current_city = "yes #{@user2_current_city}" :  @same_current_city = "different" 
    @common_activities = common_activities(params[:user_id],params[:user_id2]).count
    @common_friends = common_friends(params[:user_id],params[:user_id2])
    render :json => { :response_code => 200, :response_message => "distance" ,:distance => @distance,:from => @user.address,:to =>@second_user.address,:last_activity=>  @last_activity_hour,:last_active=> @last_active_hour ,:age_difference => @age_difference,:gender_type =>  @gender_type,:common_cities => @common_cities.count,:same_current_city => @same_current_city ,:common_activities => @common_activities,:common_friends => @common_friends}
  end

end
