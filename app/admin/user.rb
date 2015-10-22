ActiveAdmin.register User,:as => "Rating" do
  menu priority: 3
  actions :all, :except => [:new]

  index download_links: [:csv] do
    selectable_column
    column "User Name" do |resources|
       resources.profile.first_name + " " + resources.profile.last_name
    end
    column "Email" do |resources|
       resources.profile.fb_email
    end

    column "City" do |resources|
       resources.current_city
    end

    column "Total rating users" do |resources|
       resources.ratings.count
    end

    column "Rating" do |resource|
      @ratings = resource.ratings
      @rate_sum =0
       if @ratings.present?
        @ratings.each do |r|
          @rate = r.rate.to_i+0.0
          @rate_sum = @rate_sum+@rate         
        end
        @avg = "#{((@rate_sum/@ratings.count)*100).round(2)}%"
      else
        @avg = "No budy rating"
      end
    end
  end

   filter :profile_first_name_cont , :as => :string , :label => "Search By Name"
   filter :current_city_cont , :as => :string , :label => "Search By City"
    controller do
      def index
        if current_admin_user.is_admin #|| Group.set_access_for_current_admin(current_admin_user).include?("Banner list")
         super
        else
         redirect_to :back ,:alert => "You are not allowed to access this Page!"
        end
      end
    end
end
