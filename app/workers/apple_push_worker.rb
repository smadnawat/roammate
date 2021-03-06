class ApplePushWorker
	include Sidekiq::Worker
  sidekiq_options  :retry => false

   def perform(reciever,alert,badges,noti,invitation,type, device, category, name, group_id, group_user_id)
    
    p"ApplePushWorker----------------apple-----------------------Start---"
    
    pusher = Grocer.pusher(

      # certificate: Rails.root.join('RoammateDistribution.pem'),      # required
      certificate: Rails.root.join('MobiloitteDevelopmentAbdTestingStaging.pem'),      # required
      # passphrase:  "RoammateApp",                       # optional
      passphrase:  "Mobiloitte1",                       # optional
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
      custom: {:notification_type => type,:invitation_id => invitation,:notification_id => noti, :group_name => name, :group_id => group_id, :group_user_id => group_user_id },
      :badge => badges,
      :sound => "siren.aiff",         # optional
      :expiry => Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
      :identifier => 1234,                 # optional
      :content_available => true                  # optional; any truthy value will set 'content-available' to 1
      )
     pusher.push(notification)
    p "-----------------------APPLE WORKER DONE"
    p ""
  end

end


 