ActiveAdmin.register User,:as => "Rating" do
  menu priority: 3
  actions :all, :except => [:new]

  index download_links: [:csv] do
    selectable_column
    column "User Name" do |resources|
       resources.profile.first_name
    end
    column "Email" do |resources|
       resources.profile.email
    end

    column "City" do |resources|
       resources.profile.current_city
    end

    column "Rating Out Of" do |resources|
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
     filter :profile_current_city_cont , :as => :string , :label => "Search By City"

end
