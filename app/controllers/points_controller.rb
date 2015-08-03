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
    @last_active_hour = @second_user.online ? -1 : (Time.now - (@second_user.last_active_at != nil ? @second_user.last_active_at : @second_user.updated_at))/3600
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
      @gender_type = "same"
    end
    @common_cities = @user.cities&@second_user.cities
    @user1_current_city = @user.current_city
    @user2_current_city = @second_user.current_city
    @user1_current_city == @user2_current_city ?  @same_current_city = true :  @same_current_city = false
    @common_activities = common_activities(params[:user_id],params[:user_id2]).count
    @common_friends = common_friends(params[:user_id],params[:user_id2]).count
    @ratings = user_rating(@second_user.id)
    @rating_users = @second_user.ratings.count

    @points = 0

    @distance_point_field = ServicePoint.find_by_service("current location distance")
    @last_activity_point_field  = ServicePoint.find_by_service("last activity")
    @last_active_point_field = ServicePoint.find_by_service("last active")
    @age_point_field = ServicePoint.find_by_service("age")
    @gender_point_field = ServicePoint.find_by_service("gender")
    @common_activities_point_field = ServicePoint.find_by_service("common activities")
    @common_friends_point_field = ServicePoint.find_by_service("common friends")
    @common_cities_point_field = ServicePoint.find_by_service("common cities")
    @current_city_point_field = ServicePoint.find_by_service("city lived in")
    @user_rating_point_field = ServicePoint.find_by_service("user ratings")

    case @distance
      when 0 .. 6
        @points +=  @distance_point_field.point
      when 6 .. 11
        @points +=  (@distance_point_field.point*90)/100
      when 11 .. 16
        @points +=  (@distance_point_field.point*80)/100
      when 16 .. 21 
        @points +=  (@distance_point_field.point*70)/100
      when 21 .. 31
        @points +=  (@distance_point_field.point*60)/100
    else 
      @points +=  (@distance_point_field.point*50)/100
    end 

    case @last_activity_hour
      when 0 .. 1 
        @points +=  @last_activity_point_field.point
      when 1 .. 2 
        @points +=  (@last_activity_point_field.point*90)/100
      when 2 .. 3
        @points +=  (@last_activity_point_field.point*80)/100
      when 3 .. 4 
        @points +=  (@last_activity_point_field.point*70)/100
      when 4 .. 5
        @points +=  (@last_activity_point_field.point*60)/100
      when 5 .. 6
        @points +=  (@last_activity_point_field.point*50)/100
      when 6 .. 12
        @points +=  (@last_activity_point_field.point*40)/100
      when 12 .. 24
        @points +=  (@last_activity_point_field.point*30)/100
    else 
      @points +=  (@last_activity_point_field.point*20)/100
    end 

    case @last_active_hour     
      when -1
        @points +=  @last_active_point_field.point
      when 0 .. 1 
        @points +=  (@last_active_point_field.point*90)/100
      when 1 .. 2
        @points +=  (@last_active_point_field.point*80)/100
      when 2 .. 3 
        @points +=  (@last_active_point_field.point*70)/100
      when 3 .. 4
        @points +=  (@last_active_point_field.point*60)/100
      when 4 .. 5
        @points +=  (@last_active_point_field.point*50)/100
      when 5 .. 6
        @points +=  (@last_active_point_field.point*40)/100
      when 6 .. 12
        @points +=  (@last_active_point_field.point*30)/100
      when 12 .. 24
        @points +=  (@last_active_point_field.point*20)/100
    else 
      @points +=  (@last_active_point_field.point*10)/100
    end 

    case @age_difference    
      when 0 .. 4 
        @points +=  @age_point_field.point
      when 4 .. 6
        @points +=  (@age_point_field.point*90)/100
      when 6 .. 9 
        @points +=  (@age_point_field.point*80)/100
      when 9 .. 11
        @points +=  (@age_point_field.point*70)/100
      when 11 .. 16
        @points +=  (@age_point_field.point*60)/100
      when 16 .. 21
        @points +=  (@age_point_field.point*50)/100
      when 21 .. 31
        @points +=  (@age_point_field.point*40)/100
    else 
      @points +=  (@age_point_field.point*30)/100
    end

    if @gender_type == "different"
       @points += @age_point_field.point
    end

    case @common_activities
      when 0
        
      when 1
        @points +=  (@common_activities_point_field.point*30)/100
      when 2
        @points +=  (@common_activities_point_field.point*40)/100
      when 3
        @points +=  (@common_activities_point_field.point*50)/100
      when 4
        @points +=  (@common_activities_point_field.point*60)/100
      when 5
        @points +=  (@common_activities_point_field.point*70)/100
      when 6
        @points +=  (@common_activities_point_field.point*80)/100
      when 7
        @points +=  (@common_activities_point_field.point*90)/100
    else 
      @points += @common_activities_point_field.point
    end 

    case @common_friends
      when 0 .. 6 
        @points +=  (@common_friends_point_field.point*40)/100
      when 6 .. 11
        @points +=  (@common_friends_point_field.point*50)/100
      when 11 .. 21 
        @points +=  (@common_friends_point_field.point*60)/100
      when 21 .. 31
        @points +=  (@common_friends_point_field.point*70)/100
      when 31 .. 41
        @points +=  (@common_friends_point_field.point*80)/100
      when 41 .. 51
        @points +=  (@common_friends_point_field.point*90)/100
    else 
      @points +=  @common_friends_point_field.point
    end

    @same_current_city ? @points += @current_city_point_field.point : (City.find_by_city_name(@user2_current_city).country == City.find_by_city_name(@user1_current_city).country ? @points +=  (@current_city_point_field.point*90)/100 : @points)

    case @common_cities
      when 0

      when 1
        @points +=  (@common_cities_point_field.point*60)/100
      when 2
        @points +=  (@common_cities_point_field.point*70)/100
      when 3
        @points +=  (@common_cities_point_field.point*80)/100
      when 4
        @points +=  (@common_cities_point_field.point*90)/100
    else 
      @points +=  @common_cities_point_field.point
    end

    case @ratings
      when 100
        @points += @user_rating_point_field.point
      when 90 .. 100
        @points +=  (@user_rating_point_field.point.point*90)/100
      when 80 .. 90
        @points +=  (@user_rating_point_field.point.point*80)/100
      when 70 .. 80
        @points +=  (@user_rating_point_field.point.point*70)/100
      when 60 .. 70
        @points +=  (@user_rating_point_field.point.point*60)/100
      when 50 .. 60
        @points +=  (@user_rating_point_field.point.point*50)/100
    else 
      @points 
    end
    @points += user_points(@second_user.id)
    render :json => { :response_code => 200, :response_message => "distance" ,:distance => @distance,:from => @user.address,:to =>@second_user.address,:last_activity=>  @last_activity_hour,:last_active=> @last_active_hour ,:age_difference => @age_difference,:gender_type =>  @gender_type,:common_cities => @common_cities.count,:same_current_city => @same_current_city ,:common_activities => @common_activities,:common_friends => @common_friends,:rating => @ratings,:rating_users => @rating_users,:points =>@points}
  end

 def self.relative_time start_time
    diff_seconds = Time.now - start_time
    case diff_seconds
      when 0 .. 60
        return "#{diff_seconds.round(0)} sec ago"
      when 60 .. (3600-1)
        return "#{(diff_seconds/60).round(0)} min ago"
      when 3600 .. (3600*24-1)
        return "#{(diff_seconds/3600).round(0)} hrs ago"
      when (3600*24) .. (3600*24*2) 
        return "Yesterday"
    else 
      return "#{start_time.to_date}"
    end
  end

end