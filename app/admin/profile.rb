ActiveAdmin.register Profile do
  menu priority: 1
  permit_params :email, :first_name, :last_name,:dob, :image, :location, :gender, :status, :locale, :timezone
  actions :all, :except => [:new, :show]
  index do
    selectable_column
    # id_column
    column "Name" do |resource|
      resource.first_name + " " + resource.last_name
    end
    column :email
    column "Age" do |resource|
      if resource.dob.present?
        today = Date.today
        d = Date.new(today.year, resource.dob.month, resource.dob.day)
        age = d.year - resource.dob.year - (d > today ? 1 : 0)
        age1 = "#{age} Years"
      end
    end
    column "Image" do |resources|
      image_tag resources.image_url(:thumbnail)
    end
    column "Point and Ratings" do |resource|
      @points = resource.user.points
      @ratings = resource.user.ratings
      @rate_sum =0
      @point_sum =0
      # if @ratings.present?
      #   @ratings.each do |r|
      #     @rate = r.rate.to_i+0.0
      #     @rate_sum = @rate_sum+@rate         
      #   end
      #   @avg = "#{Rating = ((@rate_sum/@ratings.count)*100).round(2)}%"
      # else
      #   @avg = "did not rate by any user"
      # end

      if @points.present?
         @points.each do |p|
           @point_sum = @point_sum + p.point
         end
      else
         @point_sum = 0
      end
      "Points = #{@point_sum}"
    end
    column :location
    column "Status" do |resource|
      status_tag (resource.status ? "Active" : "Deactive"), (resource.status ? :ok : :error) 
    end    
    column "Actions" do |resource|
        links = ''.html_safe
        a do
          if resource.status?
            links += link_to 'Deactive', profile_status_path(resource),:data => { :confirm => 'Are you sure, you want to deactive this profile?' }
          else
           links += link_to 'Active', profile_status_path(resource),:data => { :confirm => 'Are you sure, you want to active this profile?' }
           end
           links += " / "
           links +=  link_to 'Edit', edit_admin_profile_path(resource)
         links += " / "  
         links += link_to 'Delete', destroy_users_path(resource.user_id), method: :delete,:data => { :confirm => 'Are you sure, you want to delete this profile?' }
       end
       links
     end
  end

  filter :email_cont, label: 'Search by email'

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      label :Please_enter_a_valid_email,:class => "label_error" ,:id => "email_label"
      f.input :first_name
      label :Please_enter_a_valid_first_name,:class => "label_error" ,:id => "fname_label"
      f.input :last_name
      f.input :image,:as => :file
      f.input :location
      f.input :dob,as: :datepicker, datepicker_options: { max_date: 18.years.ago.to_date}
      label :Please_enter_date_of_birth,:class => "label_error" ,:id => "dob_label"
      f.input :gender, :as => :select,collection: [["male","male"],["female","female"]],include_blank: false, allow_blank: false
      f.input :locale
      f.input :timezone
    end 
    f.actions
  end

  # show do
  #   attributes_table do
  #     row :interest_name
  #     row :description
  #     row "Images" do |resources|
  #       image_tag(resources.image.url(:thumbnail))
  #     end
  #     row :image
  #     row :icon
  #     row :status
  #     row :catagory
  #    end
  # end

end

