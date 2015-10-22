class UploadFilesController < ApplicationController
	def upload_file
		@file = Profile.import(params[:upload_csv][:file])
		if @file == "y"		
		  flash[:notice] = "File uploaded successfully"
		else
		  flash[:error] = @file
		end
		redirect_to admin_upload_file_path
	end

	def send_message
		@user = User.find_by_id(params[:user_id])
    @type = "Admin message"
    @badge = Notification.where("reciever = ? and status = ?",@user.id ,false).count
    @user.devices.each {|device| (device.device_type == "android") ? AndroidPushWorker.perform_async(@user.id, "Admin: #{params[:send_message][:message]}", @badge, nil, nil, @type, device.device_id, nil, nil, nil, nil ) : ApplePushWorker.perform_async( @user.id, "Admin: #{params[:send_message][:message]}", @badge, nil, nil, @type, device.device_id, nil, nil, nil, nil ) } if @user.message_notification
		redirect_to admin_profiles_path, :notice => "Message Successfully Sent"
	end

end
