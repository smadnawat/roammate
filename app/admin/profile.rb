ActiveAdmin.register Profile do
  menu priority: 1
  permit_params :email,:fb_email, :first_name, :last_name,:dob, :image, :location, :gender, :status
  actions :all, :except => [:new, :show]

  action_item :only => :index do
    link_to 'Upload CSV',  admin_upload_file_path
  end

  index :title => "Total users #{Profile.all.count}", download_links: [:csv] do

    selectable_column
    # id_column
    column "Name" do |resource|
      resource.first_name + " " + resource.last_name
    end
    # column "Roammate email" do |resource|
    #   resource.email
    # end
    column "Facebook email" do |resource|
      resource.fb_email
    end
    column "Age" do |resource|
      if resource.dob.present?
        today = Date.today
        d = Date.new(today.year, resource.dob.month, resource.dob.day)
        age = d.year - resource.dob.year - (d > today ? 1 : 0)
        age1 = "#{age} Years"
      end
    end
    column "Image" do |resources|
      image_tag("#{resources.image}") if resources.image.present?
    end
    column "Point" do |resource|
      @points = resource.user.points
      @point_sum =0
      if @points.present?
         @points.each do |p|          
           @point = ServicePoint.find_by_service(p.pointable_type)
           @point_sum = @point_sum + @point.point
         end
      else
         @point_sum = 0
      end
      "Points = #{@point_sum}"
    end
    column :location
    column :current_city
    column "Status" do |resource|
      status_tag (resource.status ? "Active" : "Deactive"), (resource.status ? :ok : :error) 
    end    
    column :created_at
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

  filter :fb_email_cont, label: 'Search by email'

  form do |f|
    f.inputs "Admin Details" do
      f.input :fb_email,:label => "Facebook email"
      label :Please_enter_a_valid_email,:class => "label_error" ,:id => "email_label"
      f.input :first_name
      label :Please_enter_a_valid_first_name,:class => "label_error" ,:id => "fname_label"
      f.input :last_name
      label :Please_enter_a_valid_last_name,:class => "label_error" ,:id => "lname_label"
      #f.input :image,:as => :file
      f.input :location
      f.input :dob,as: :datepicker, datepicker_options: { max_date: 18.years.ago.to_date}
      label :Please_enter_date_of_birth,:class => "label_error" ,:id => "dob_label"
      f.input :gender, :as => :select,collection: [["male","male"],["female","female"]],include_blank: false, allow_blank: false
    end 
    f.actions
  end

end

