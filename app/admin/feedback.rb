ActiveAdmin.register Feedback do
  menu priority: 6
  actions :all, :except => [:new, :edit]
  # permit_params :email, :password, :password_confirmation

  index download_links: [:csv] do
    selectable_column
    # id_column
    column "From(Email)" do |resources|
      resources.user.profile.fb_email
    end
    column "Feedback" do |resources|
      resources.content
    end 
    column "Date" do |resources|
      resources.created_at.to_date
    end
    actions name: "Actions"
  end

  filter :user_profile_email_cont, :as => :string , :label => "Search By Email"
 
  show :title => "Feedback" do
    attributes_table do
      row :content
      row "User" do |resources|
        resources.user.profile.first_name
      end

      row "Email" do |resources|
        resources.user.profile.fb_email
      end
      
      row :created_at
    end
  end

  controller do
      def index
        if current_admin_user.is_admin 
         super
        else
         redirect_to :back ,:alert => "You are not allowed to access this Page!"
        end
      end
    end


end
