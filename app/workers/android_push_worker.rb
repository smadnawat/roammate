require 'gcm'
class AndroidPushWorker
  include Sidekiq::Worker

  def perform(reciever,alert,badges,notification,invitation)
p "=============INSIDE THE WORKER============"
p "|"
p "|"
p "|"
p "|"
  p "%%%%%%%%%%%%% Inside AndroidPushWorker %%%%%%%%%%%%%%%%%%" 
  logger.info "+++++++#{reciever}=======#{alert}++++++#{badges}======#{notification}+++++++#{invitation}======"

    @device = Device.where(:user_id => reciever.to_i)
    p "++++++++Inside device ===>>>>     #{@device.inspect} +++++++++"
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
p "|"
p "|"
p "|"
p "|"
p "=============Outside THE WORKER============"
  end
end
