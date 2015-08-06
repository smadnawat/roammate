
class ApplePushWorker
	include Sidekiq::Worker

  def perform(reciever,alert,badges,noti)
    pusher = Grocer.pusher(
      certificate: Rails.root.join('MobiloitteDevApp.pem'),      # required
      passphrase:  "Mobiloitte",                       # optional
      gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
      port:        2195,                     # optional
      retries:     3                         # optional
    )
    @device = Device.where(:user_id => reciever.to_i)
    notification = Grocer::Notification.new(
      :device_token => "#{@device.last.device_id}",
      :alert =>  alert,
      custom: {:notification_id => noti},
      :badge => badges,
      :sound => "siren.aiff",         # optional
      :expiry => Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
      :identifier => 1234,                 # optional
      :content_available => true                  # optional; any truthy value will set 'content-available' to 1
      )
     pusher.push(notification)
  end
end

