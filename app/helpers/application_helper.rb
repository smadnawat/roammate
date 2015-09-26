module ApplicationHelper
	def common_activities user,member
		@interests = User.find_by_id(user).interests & User.find_by_id(member).interests
		@interest = []
			@interests.each do |i|
				@int = {}
				@int[:id] =  i.id
				@int[:interest_name] =  i.interest_name
				@int[:image] =  i.image.url
				@int[:icon] =  i.icon.url
				@int[:banner]= i.banner.url
				@int[:description] = i.description		
				@int[:color] = i.color
				@interest << @int
			end
			return @interest
	end

	# def user_is_block? user,member
	# 	@ublock = Block.find_by_user_id_and_member_id_and_is_block(user, member, true)
	# 	if @ublock.present?
	# 		return true
	# 	else
	# 		return false
	# 	end
	# end

	def blocked_user_list user
		@arr = []
		user.blocks.where(is_block: true).each do |blk|
			@arr << blk.member_id
		end
		@arr
	end

	def user_liked_events user
		if user.likes.present?
			eve = []
			user.likes.each do |e|
				@even = {}
				@even[:event_name] = e.event.event_name
				@even[:place] = e.event.place
				@even[:city] = e.event.city
				@even[:link] = e.event.link
				@even[:event_date] = e.event.event_date
				@even[:host_name] = e.event.host_name
				@even[:image] = e.event.image.url
				eve << @even
			end
			eve
		else
			eve = []
		end
	end

	def is_friend user,member
		@invitation = Invitation.where(:reciever => [user,member] ,:user_id =>[user,member], :status => true).first
		if @invitation.present?
			@invitation
		else
			false
		end
	end

	def predefined_events user
		@events = Event.where('event_date >= ?', Date.today)
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
				@eve[:event_date] = e.event_date.to_date
				@eve[:host_name] = e.host_name
				@eve[:image] = e.image.url
				@eve[:total_likes] = e.likes.where(status: true).count
				@stat = user.likes.where('event_id = ?', e.id).first
				@eve[:status] = @stat.present? ? @stat.status : false
				@event << @eve
			end
		end
		@event
	end

	def message_count user, group
		@first_user_message_count = group.messages.where("user_id = ?",user.id).count#Message.where('(user_id = ? and reciever = ?) or (user_id = ? and reciever = ?)',user,member,member,user).count
		@second_user_message_count = group.messages.where("user_id = ?",group.group_name.to_i).count#Message.where('(user_id = ? and reciever = ?) or (user_id = ? and reciever = ?)',member,user,user,member).count
		if @first_user_message_count >= 10 && @second_user_message_count >= 10
			true
		else
			false
		end
	end

	def common_friends user,member
		@user1_invitation = Invitation.where('user_id = ? OR reciever = ? and status= ?', user, user,true)
		@user2_invitation = Invitation.where('user_id = ? OR reciever = ? and status= ?', member, member,true)
		@user1_friends = []
		@user2_friends = []
		@user1_invitation.each do |inv|
			if inv.user_id == user.to_i
				@user1_friends<<inv.reciever
			else
				@user1_friends<<inv.user_id
			end
		end
		@user2_invitation.each do |inv|
			if inv.user_id == member.to_i
				@user2_friends<<inv.reciever
			else
				@user2_friends<<inv.user_id
			end
		end 
		common_friends = @user1_friends & @user2_friends
	end

	def find_age user
		#@user = User.find_by_id(user)
		today = Date.today
        d = Date.new(today.year, user.profile.dob.month, user.profile.dob.day)
        age = d.year - user.profile.dob.year - (d > today ? 1 : 0)
	end

	def user_rating user
	  @ratings = User.find(user).ratings
	    @rate_sum =0
	    if @ratings.present?
	      @ratings.each do |r|
	        @rate = r.rate.to_i+0.0
	        @rate_sum = @rate_sum+@rate         
	      end
	      @avg = ((@rate_sum/@ratings.count)*100).round(2)
	    else
	      @avg = 0
	    end 
  end	

  def user_points user
	  @user1 = User.find_by_id(user)
    @points = @user1.points
    @point_sum =0
    if @points.present?
       @points.each do |p|          
         @point = ServicePoint.find_by_service(p.pointable_type)
         @point_sum = @point_sum + @point.point
       end
    else
       @point_sum = 0
    end    		
    @point_sum
  end
    
  def point_algo current,second
  	@user = User.find(current)
    @second_user = User.find(second)
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
    @common_activities = common_activities(current,second).count
    @common_friends = common_friends(current,second).count
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
	end

end
