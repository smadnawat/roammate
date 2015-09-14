class NotificationsController < ApplicationController

	before_filter :check_user

	def settings
		@user.update_attributes(:message_notification => params[:new_message]=="off" ? false : true  ) if params[:new_message].present?
		@user.update_attributes(:friend_request_notification => params[:friend_request]=="off" ? false : true ) if params[:friend_request].present?
		@user.update_attributes(:new_event_notification => params[:new_event]=="off" ? false : true  ) if params[:new_event].present?
		@user.update_attributes(:updates_notification => params[:updates]=="off" ? false : true  ) if params[:updates].present?
		@set = {}
		@set["new_message"]  = @user.message_notification ? "on" : "off"
		@set["friend_request"] = @user.friend_request_notification ? "on" : "off"
		@set["new_event"] = @user.new_event_notification ? "on" : "off"
		@set["updates"] = @user.updates_notification ? "on" : "off"
		render :json => {
							:response_code => 200, :message => "Setting updated",
							:settings => @set
							}
	end

	def gender_update
		@user.profile.update_attributes(:gender => params[:gender]) if params["gender"].present?
		render :json => {
							:response_code => 200, :message => "Setting updated"
							}
	end

	def my_notifications
		@notifications = Notification.where(reciever: @user.id)
		if @notifications.present?		
			@note = []
			@notifications.each do |notice|
				@pr = Profile.find_by_id(notice.reciever)#.attributes.merge!(:notice => notice)
				@p = {}
				@p["user_id"] = @pr.id
				@p["image"] = @pr.image
				@p["first_name"] =@pr.first_name
				@p["last_name"] = @pr.last_name
				@p["noti_type"] = notice.notification_type
				@p["message"] = notice.message
				@note << @p
			end			
			render :json => {
							:response_code => 200, :message => "record successfully fetched",
							:notifications => @note
							}
		else
			render :json => {
							:response_code => 500,
							:message => "No record found."
							}
		end
	end

end
