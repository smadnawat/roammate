class NotificationsController < ApplicationController

	before_filter :check_user
	def my_notifications
		@notifications = Notification.where(reciever: @user.id)
		if @notifications.present?
			@noti = {}
			@note = []
			@notifications.each do |notice|
				@note << Profile.find_by_id(notice.reciever).attributes.merge!(:notice => notice)
			end
			@noti[:user] = @note
			render :json => {
											:response_code => 200, :message => "record successfully fetched",
											:notifications => @noti
											}
		else
			render :json => {
											:response_code => 500,
											:message => "No record found."
											}
		end
	end

end
