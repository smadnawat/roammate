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
end
