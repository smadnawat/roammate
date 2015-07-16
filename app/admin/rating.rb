ActiveAdmin.register User,:as => "Rating" do
  menu priority: 3
  actions :all, :except => [:new]

  index do
    selectable_column
    column "User Name" do |resources|
       resources.profile.first_name
    end
    column "Email" do |resources|
       resources.profile.email
    end
    column "Rating" do |resource|
      @ratings = resource.ratings
      @rate_sum =0
       if @ratings.present?
        @ratings.each do |r|
          @rate = r.rate.to_i+0.0
          @rate_sum = @rate_sum+@rate         
        end
        @avg = "#{(@rate_sum/@ratings.count)*100}%"
      else
        @avg = "No budy rating"
      end
    end
  end

     filter :profile_first_name_cont , :as => :string , :label => "Search By Name"

end
