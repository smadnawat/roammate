require 'gcm'
class AndroidPushWorker
  include Sidekiq::Worker
  
  def perform(reciever,alert,badges,notification,invitation)
    @device = Device.where(:user_id => reciever.to_i)
    gcm = GCM.new("AIzaSyDGIkZOsPJIqf6p6m9dWuZq_bFtEvMNcnM")
    registration_ids= ["#{@device.last.device_id}"]
    options = {
         'data' => {
          'alert' => alert,
          'badge' => badges,
          'notification_id' => notification,
          'invitation_id' => invitation
         },
        "time_to_live" => 108,
        "delay_while_idle" => true,
        "collapse_key" => 'updated_state'
        }
    response = gcm.send_notification(registration_ids,options)
  end
end
