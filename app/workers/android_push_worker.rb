require 'gcm'
class AndroidPushWorker
  include Sidekiq::Worker

    def perform(reciever,alert,badges,notification,invitation,type, device_id, image)
      logger.info"===================#{reciever.inspect}===#{alert.inspect}==========#{badges.inspect}==============#{device_id.inspect}==========#{type.inspect}============#{invitation.inspect}======="
         p"==============#{device_id}=================IN ANDROID WORKER"
        gcm = GCM.new("AIzaSyDGIkZOsPJIqf6p6m9dWuZq_bFtEvMNcnM")
        registration_ids = ["#{device_id}"]         
        options = {
              'data' => {
              'message' => ['badge'=>  badges,'alert' => alert,'invitation_id' => invitation,'notification_type' => type,"notification_id" => notification, "image" => image]
              },
            "time_to_live" => 108,
            "delay_while_idle" => true,
            "collapse_key" => 'updated_state'
            }
        response = gcm.send_notification(registration_ids,options)
        puts "=============Done======#{response.inspect}======== ANDROID WORKER"
      end

end

