ActiveAdmin.register Feedback do
  menu priority: 6
  actions :all, :except => [:new, :edit]
  # permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    # id_column
    column "From(Email)" do |resources|
      resources.user.profile.email
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
        resources.user.profile.email
      end
      
      row :created_at
    end
  end


end
