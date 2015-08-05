
class ApplePushWorker
	include Sidekiq::Worker

  def perform(reciever,alert,badges,device,type,group_id)
    pusher = Grocer.pusher(
      certificate: Rails.root.join('crowdchat.pem'),      # required
      passphrase:  "cofounder",                       # optional
      gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
      port:        2195,                     # optional
      retries:     3                         # optional
    )
    #Rails.logger.info "===============#{device.inspect}==================="
    notification = Grocer::Notification.new(
      :device_token => device.to_s,
      :alert =>  alert,
      custom: {:alert_type => type,:invitation_id => invitation.id},
      :badge => badges,
      :sound => "siren.aiff",         # optional
      :expiry => Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
      :identifier => 1234,                 # optional
      :content_available => true                  # optional; any truthy value will set 'content-available' to 1
      )
     pusher.push(notification)

  end
end

