class Notification < ActiveRecord::Base
  belongs_to :user

  def self.create_notification(user,reciever,type,invitation)
    logger.info"---------------------#{invitation.inspect}-------------"
  	@alert = alert(user,type)
  	notification = create(:user_id => user.id,:reciever => reciever.id,:notification_type => type,:message => @alert,:status => false)
  	if reciever.friend_request_notification
      badges = Notification.where("reciever = ? and status = ?",reciever.id ,false).count
      image = user.profile.image
    	@devices = reciever.devices
    	unless @devices.nil?
        p "+++++++++++#{type}+++++++++++++++"
  	    @devices.each do |device|
  	       if device.device_type == "android"
  	       	 #p "============#{@notification.inspect}============#{reciever.inspect}"
  	         AndroidPushWorker.perform_async(reciever.id, @alert, badges, notification.id, invitation, type, device.device_id, image, nil, nil )
  	       else
            (type == "Send chat") ? @category = "ACTIONABLE" : @category = nil
            p "++++++++++++++++#{@category.inspect}+++++++++++++++++++++"
  	         ApplePushWorker.perform_async(reciever.id, @alert, badges, notification.id, invitation, type, device.device_id, @category, nil, nil)
  	       end
  	    end
      end
    end
  end

  def self.alert(user,type)
  case type
  	when "Send chat"
  		return "#{user.profile.first_name.capitalize} send you a chat invitation"
  	when "accept chat"
  		return "#{user.profile.first_name.capitalize} has accepted your chat invitation"
  	end
  end
end
