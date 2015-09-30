require 'gcm'
class AndroidPushWorker
  include Sidekiq::Worker

    def perform(reciever,alert,badges,notification,invitation,type, device_id, image, name, group_id)
      p "=======image=#{image}========group_id==#{group_id}====notification_id=#{notification}=======group_name=#{name}========reciever_id==#{reciever.inspect}=======alert=#{alert.inspect}=========badges=#{badges.inspect}=============device_id=#{device_id.inspect}=========notification_type=#{type.inspect}==========invitation_id==#{invitation.inspect}======="
         p"==============#{device_id}=================IN ANDROID WORKER"
        gcm = GCM.new("AIzaSyDGIkZOsPJIqf6p6m9dWuZq_bFtEvMNcnM")
        registration_ids = ["#{device_id}"]         
        options = {
              'data' => {
              'message' => ['badge'=>  badges,'alert' => alert,'invitation_id' => invitation,'notification_type' => type,"notification_id" => notification, "image" => image, "group_name" => name, "group_id" => group_id]
              },
            "time_to_live" => 108,
            "delay_while_idle" => true,
            "collapse_key" => 'updated_state'
            }
        response = gcm.send_notification(registration_ids,options)
        p "=============Done======#{response.inspect}======== ANDROID WORKER"
      end

end

