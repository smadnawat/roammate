class PointsController < ApplicationController
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
    @last_activity_hour = Time.now.hour - @second_user.created_at.hour
    render :json => { :response_code => 200, :response_message => "distance" ,:distance => @distance,:last_activity=>  @last_activity_hour,:from => @user.address,:to =>"#{@second_user.latitude} === #{@second_user.longitude}" }
  end

end
