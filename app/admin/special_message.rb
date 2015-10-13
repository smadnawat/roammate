ActiveAdmin.register SpecialMessage do
  menu priority: 14
  permit_params :content, :interest_id

  index download_links: [:csv] do
    selectable_column
    column "Message" do |resources|
      resources.content
    end
    column "Interest" do |resources|
      resources.interest.interest_name
    end
    column "Created Time" do |resources|
      resources.created_at.to_date
    end
  column "Status" do |resource|
    status_tag (resource.status ? "Active" : "Deactive"), (resource.status ? :ok : :error) 
  end
      column "Actions" do |resource|
      links = ''.html_safe
      a do
        if resource.status?
          links += link_to 'Deactive', special_message_status_path(resource),:data => { :confirm => 'Are you sure, you want to deactive this profile?' }
        else
         links += link_to 'Active', special_message_status_path(resource),:data => { :confirm => 'Are you sure, you want to active this profile?' }
         end
          links += " / "
          links +=  link_to 'Edit', edit_admin_special_message_path(resource)
          links += " / "  
          links += link_to 'Delete', admin_special_message_path(resource), method: :delete,:data => { :confirm => 'Are you sure, you want to delete this profile?' }
          links += " / "  
          links += link_to 'View', admin_special_message_path(resource)

     end
     links
   end
  end

  filter :interest_interest_name_cont, :as => :string , :label => "Search By Interest"

  form do |f|
    f.inputs "Admin Details" do
      f.input :content,:label => "Message"
      label :Please_enter_message,:class => "label_error" ,:id => "message_new_label"
      f.input :interest_id, :as => :select, :collection => Interest.all.map{|u| ["#{u.interest_name}", u.id]},include_blank: false, allow_blank: false
      f.input :city, :as => :select, :collection => City.all.map{|u| ["#{u.city_name}", u.id]},include_blank: true, allow_blank: false
    end
    f.actions
  end

  show :title => "Special Messages" do
    attributes_table do
      row "Message" do |resources|
        resources.content
      end
      row "Interest" do |resources|
        resources.interest.interest_name
      end
      row "Status" do |resources|
        status_tag (resource.status ? "Active" : "Deactive"), (resource.status ? :ok : :error) 
      end
      row :created_at
    end
  end

  controller do

    def create
      p "++++++++++++++++++++#{params.inspect}++++++"
      super
      if params[:special_message][:city].present?
      @city = City.find(params[:special_message][:city])
      @interest = Interest.find(params[:special_message][:interest_id])
      @city.users.select{|x|(x.interests.include?(@interest))}.each do |snd|
        @type = "Admin message"
        @badge = Notification.where("reciever = ? and status = ?",snd.id ,false).count
        snd.devices.each {|device| (device.device_type == "android") ? AndroidPushWorker.perform_async(snd.id, "Admin: #{params[:special_message][:content]}", @badge, nil, nil, @type, device.device_id, nil, nil, nil ) : ApplePushWorker.perform_async( snd.id, "Admin: #{params[:special_message][:content]}", @badge, nil, nil, @type, device.device_id, nil, nil, nil ) } if snd.message_notification
      end
      else
        @interest = Interest.find(params[:special_message][:interest_id])
        @interest.users.each do |snd|
        @type = "Admin message"
        @badge = Notification.where("reciever = ? and status = ?",snd.id ,false).count
        snd.devices.each {|device| (device.device_type == "android") ? AndroidPushWorker.perform_async(snd.id, "Admin: #{params[:special_message][:content]}", @badge, nil, nil, @type, device.device_id, nil, nil, nil ) : ApplePushWorker.perform_async( snd.id, "Admin: #{params[:special_message][:content]}", @badge, nil, nil, @type, device.device_id, nil, nil, nil ) } if snd.message_notification
      end
      end
    end

    def index
      if current_admin_user.is_admin 
       super
      else
       redirect_to :back ,:alert => "You are not allowed to access this Page!"
      end
    end

  end

end
