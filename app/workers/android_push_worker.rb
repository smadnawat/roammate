require 'gcm'
class AndroidPushWorker
  include Sidekiq::Worker
  sidekiq_options  :retry => false

  def perform(reciever,alert,badges,notification,invitation,type, device_id, image, name, group_id, group_user_id)     
    p "AndroidPushWorker=============================Start"
      gcm = GCM.new("AIzaSyDGIkZOsPJIqf6p6m9dWuZq_bFtEvMNcnM")
      registration_ids = ["#{device_id}"]         
      options = {
            'data' => {
            'message' => ['badge'=>  badges,'alert' => alert,'invitation_id' => invitation,'notification_type' => type,"notification_id" => notification, "image" => image, "group_name" => name, "group_id" => group_id, "group_user_id" => group_user_id]
            },
          "time_to_live" => 108,
          "delay_while_idle" => true,
          "collapse_key" => 'updated_state'
          }
      response = gcm.send_notification(registration_ids,options)
      p "AndroidPushWorker=============================Done"
      p ""
    end

end

