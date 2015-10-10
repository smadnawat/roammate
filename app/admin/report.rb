ActiveAdmin.register Report do

  menu priority: 15
  actions :all, :except => [:new, :edit, :show]
  # permit_params :email, :password, :password_confirmation

  index download_links: [:csv] do
    selectable_column
    # id_column
    column "Report User" do |resources|
    	Profile.find_by_id(resources.member_id).first_name.capitalize + " " + Profile.find_by_id(resources.member_id).last_name.capitalize
    end
    column "Report User Email" do |resources|
      Profile.find_by_id(resources.member_id).fb_email.capitalize
    end
    column "Reported By" do |resources|
      resources.user.profile.first_name.capitalize + " " + resources.user.profile.last_name.capitalize
    end 
    column "Reported By User Email" do |resources|
      Profile.find_by_id(resources.user_id).fb_email.capitalize
    end 
    column "Reported On" do |resource|
      time_ago_in_words(resource.created_at.to_date)+ " Ago"
    end
    column "Status" do |resource|
      status_tag ((Profile.find_by_id(resource.member_id).status) ? "Active" : "Deactive"), ((Profile.find_by_id(resource.member_id).status) ? :ok : :error) 
    end
    column "Message" do |resources|
      	resources.user.profile.first_name.capitalize + " reports " + Profile.find_by_id(resources.member_id).first_name.capitalize
    end
  	column "Actions" do |resource|
        links = ''.html_safe
          a do
            if (Profile.find_by_id(resource.member_id).status)
              links += link_to 'Deactive', report_status_path(resource.member_id), method: :get,:data => { :confirm => 'Are you sure, you want to deactive this reported user?' }
            else
             	links += link_to 'Active', report_status_path(resource.member_id), method: :get,:data => { :confirm => 'Are you sure, you want to active this reported user?' }
            end
           links += " / "  
           links += link_to 'Delete', admin_report_path(resource), method: :delete,:data => { :confirm => 'Are you sure, you want to delete this report?' }
          end
       links
    end
  end
  filter :user_profile_first_name_cont , :as => :string , label: 'search by Reported By'

end
