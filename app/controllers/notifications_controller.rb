class NotificationsController < ApplicationController

	before_filter :check_user

	def get_settings
		@set = {}
		@set["new_message"]  = @user.message_notification ? "on" : "off"
		@set["friend_request"] = @user.friend_request_notification ? "on" : "off"
		@set["new_event"] = @user.new_event_notification ? "on" : "off"
		@set["updates"] = @user.updates_notification ? "on" : "off"
		render :json => {
							:response_code => 200, :message => "Settings fetched successfully",
							:settings => @set
							}
	end

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

	def get_gender
		render :json => {
							:response_code => 200, :message => "Gender get successfully", :gender => @user.profile.gender
							}
	end

	def gender_update
		@user.profile.update_attributes(:gender => params[:gender]) if params["gender"].present?
		render :json => {
							:response_code => 200, :message => "Setting updated"
							}
	end


	def my_notifications
		@notifications = Notification.where(reciever: @user.id).paginate(:page => params[:page], :per_page => params[:size])
		@max = @notifications.total_pages
		@total_entries = @notifications.total_entries
		if @notifications.present?		
			@note = []
			@notifications.each do |notice|
				@pr = Profile.find_by_id(notice.user_id)#.attributes.merge!(:notice => notice)
				@p = {}
				@p["user_id"] = @pr.id
				@p["notification_id"] = notice.id
				@p["image"] = @pr.image
				@p["first_name"] =@pr.first_name
				@p["last_name"] = @pr.last_name
				@p["noti_type"] = notice.notification_type
				@p["message"] = notice.message
				@p["created_at"] = notice.created_at.to_i
				@p["is_friend"] = is_friend(notice.reciever, notice.user_id).present?
				@p["is_friend"] ? @p["group_id"] = Group.where(group_admin: [notice.reciever, notice.user_id], group_name: [notice.reciever.to_s, notice.user_id.to_s]).first.id : @p["group_id"] = nil
				notice.notification_type == "Send chat" ? @p["invitation_id"] = Invitation.where("reciever = ? and user_id = ?", notice.reciever,notice.user_id).first.id : @p["invitation_id"] = nil
				@note << @p
			end			
			render :json => {
							:response_code => 200, :message => "record successfully fetched",
							:notifications => @note,
							:pagination => { :page => params[:page], :size=> params[:size], :max_page => @max, :total_entries => @total_entries}
							}
		else
			render :json => {
							:response_code => 500,
							:message => "No record found."
							}
		end
	end

end
