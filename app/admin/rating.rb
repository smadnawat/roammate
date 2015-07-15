ActiveAdmin.register Rating do
  menu priority: 3
  actions :all, :except => [:new]

  index do
    selectable_column
    column "User Name" do |resources|
      resources.user.profile.first_name + " " + resources.user.profile.last_name
    end
    column "Email" do |resources|
      resources.user.profile.email
    end
    column "Rating" do |resources|
      resources.rate
    end
  end

    filter :user_profile_first_name_cont , :as => :string , :label => "Search By Name"

end
