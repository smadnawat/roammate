ActiveAdmin.register Report do

  menu priority: 15
  actions :all, :except => [:new, :edit, :show]
  # permit_params :email, :password, :password_confirmation

  index download_links: [:csv] do
    selectable_column
    # id_column
    column "Report User" do |resources|
    	Profile.find_by_id(resources.member_id).first_name.capitalize
    end
    column "Reported By" do |resources|
      	resources.user.profile.first_name.capitalize
    end 
    # column "Status" do |resource|
    # 	p "+++++++++++++++++++#{resource.inspect}+++++++++++++++++++++++++++++++++++"
    #   status_tag ((Profile.find_by_id(resource.member_id).status) ? "Active" : "Deactive"), (resource.user.profile.status ? :ok : :error) 
    # end
    # column "Message" do |resources|
    #   	resources.user.profile.first_name.capitalize + " reports " + Profile.find_by_id(resources.member_id).first_name.capitalize
    # end
  	# column "Actions" do |resource|
   #      links = ''.html_safe
   #        a do
   #          if resource.user.profile.status?              	
   #            links += link_to 'Deactive', report_status_path(resource.member_id), method: :get,:data => { :confirm => 'Are you sure, you want to deactive this reported user?' }
   #          else
   #           	links += link_to 'Active', report_status_path(resource.member_id), method: :get,:data => { :confirm => 'Are you sure, you want to active this reported user?' }
   #          end
   #         links += " / "  
   #         links += link_to 'Delete', admin_report_path(resource), method: :delete,:data => { :confirm => 'Are you sure, you want to delete this report?' }
   #        end
   #     links
   #  end
   actions name: "Actions"
  end
   config.filters = false
  # filter false
  # filter :profile_first_name_cont , :as => :string , label: 'search by Report User'
  # filter :profile_first_name_cont, label: 'search by Reported By'
  # filter :user_profile_email_cont, :as => :string , :label => "Search By Email"
 
  # show :title => "Feedback" do
  #   attributes_table do
  #     row :content
  #     row "User" do |resources|
  #       resources.user.profile.first_name
  #     end

  #     row "Email" do |resources|
  #       resources.user.profile.fb_email
  #     end
      
  #     row :created_at
  #   end
  # end



end
