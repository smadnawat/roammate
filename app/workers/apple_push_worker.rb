
class ApplePushWorker
	include Sidekiq::Worker

  def perform(reciever,alert,badges,noti,invitation)
  p "=============INSIDE THE WORKER============"
  p "|"
  p "|"
  p "|"
  p "|"
  p "%%%%%%%%%%%%% Inside ApplePushWorker %%%%%%%%%%%%%%%%%%" 
  logger.info "+++++++#{reciever}=======#{alert}++++++#{badges}======#{noti}+++++++#{invitation}======"
    pusher = Grocer.pusher(
      certificate: Rails.root.join('MobiloitteDevelopmentAbdTesting.pem'),      # required
      passphrase:  "Mobiloitte1",                       # optional
      gateway:     "gateway.sandbox.push.apple.com", # optional; See note below.
      port:        2195,                     # optional
      retries:     3                         # optional
    )
    @device = Device.where(:user_id => reciever.to_i)
    p "++++++++Inside device ===>>>>     #{@device.inspect} +++++++++"
    notification = Grocer::Notification.new(
      :device_token => "#{@device.last.device_id}",
      :alert =>  alert,
      custom: {:notification_id => noti,:invitation_id => invitation},
      :badge => badges,
      :sound => "siren.aiff",         # optional
      :expiry => Time.now + 60*60,     # optional; 0 is default, meaning the message is not stored
      :identifier => 1234,                 # optional
      :content_available => true                  # optional; any truthy value will set 'content-available' to 1
      )
     pusher.push(notification)
    p "|"
    p "|"
    p "|"
    p "|"
    p "=============Outside THE WORKER============"
  end
end

