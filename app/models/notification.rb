class Notification < ActiveRecord::Base
  belongs_to :user

  def self.create_notification(user,reciever,type,invitation,name,group_id)
  	@alert = alert(user,type)
  	notification = create(:user_id => user.id,:reciever => reciever.id,:notification_type => type,:message => @alert,:status => false)
  	if reciever.friend_request_notification
      badges = Notification.where("reciever = ? and status = ?",reciever.id ,false).count
      image = user.profile.image
    	@devices = reciever.devices
      if group_id.present?
        @grp = Group.find(group_id)
        @grp.users.count == 2 ? group_user_id = @grp.users.where("id != ?", @p["user_id"]).first.id : group_user_id = nil
      else
        group_user_id = nil
      end  
    	unless @devices.nil?
  	    @devices.each do |device|
  	       if device.device_type == "android"
  	         AndroidPushWorker.perform_async(reciever.id, @alert, badges, notification.id, invitation, type, device.device_id, image, name, group_id, group_user_id )
  	       else
            (type == "Send chat") ? @category = "ACTIONABLE" : @category = nil
  	         ApplePushWorker.perform_async(reciever.id, @alert, badges, notification.id, invitation, type, device.device_id, @category, name, group_id, group_user_id)
           end
  	    end
      end
    end
  end

  def self.alert(user,type)
  case type
  	when "Send chat"
  		return "#{user.profile.first_name.capitalize} wants to chat"
  	when "accept chat"
  		return "#{user.profile.first_name.capitalize} is now your roammate"
  	end
  end

end
