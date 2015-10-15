class ApplePushWorker
	include Sidekiq::Worker
  sidekiq_options  :retry => false

   def perform(reciever,alert,badges,noti,invitation,type, device, category, name, group_id)
    
    p"----------------apple--------------------------"
    logger.info"=======category=#{category}========group_id==#{group_id}====notification_id=#{noti}=======group_name=#{name}========reciever_id==#{reciever.inspect}=======alert=#{alert.inspect}=========badges=#{badges.inspect}=============device_id=#{device.inspect}=========notification_type=#{type.inspect}==========invitation_id==#{invitation.inspect}======="
    
    pusher = Grocer.pusher(

      certificate: Rails.root.join('RoammateDistribution.pem'),      # required
      passphrase:  "RoammateApp",                       # optional
      gateway:     "gateway.push.apple.com", # optional; See note below.
      # gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
      port:        2195,                     # optional
      retries:     3                         # optional
    )
    #Rails.logger.info "===============#{device.inspect}==================="
    notification = Grocer::Notification.new(
      :device_token => device.to_s,
      :alert =>  alert,
      :category => category,
      custom: {:notification_type => type,:invitation_id => invitation,:notification_id => noti, :group_name => name, :group_id => group_id },
      :badge => badges,
      :sound => "siren.aiff",         # optional
      :expiry => Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
      :identifier => 1234,                 # optional
      :content_available => true                  # optional; any truthy value will set 'content-available' to 1
      )
     pusher.push(notification)
    p "-----------------------APPLE WORKER DONE"
    p ""
    p ""
    p ""
  end

end


 