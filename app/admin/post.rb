ActiveAdmin.register Post do
  menu priority: 8
  permit_params :title, :content, :image, :user_id
  actions :all, :except => [:new]
  index do
    selectable_column
    column "User Name" do |resources|
      resources.user.profile.first_name
    end
    column "Post" do |resources|
      resources.title
    end
    column "City" do |resources|
      resources.user.profile.location
    end
    column "Date" do |resources|
      resources.created_at.to_date
    end
    actions name: "Actions"
  end

  filter :user_profile_first_name_cont, label: 'Search by User Name'

  show do
    attributes_table do
      row :title
      row :content
      row "Image" do |resources|
        image_tag resources.image_url(:display)
      end
      row "User" do |resources|
        resources.user.profile.first_name
      end
    end
  end


  form do |f|
    f.inputs "Admin Details" do
      f.input :title
      label :Please_enter_title,:class => "label_error" ,:id => "title_label"
      f.input :content
      label :Please_enter_content,:class => "label_error" ,:id => "content_label"
      f.input :image,:as => :file
      f.input :user_id, :as => :select, :collection => User.all.map{|u| ["#{u.profile.first_name} #{u.profile.last_name}", u.id]}
    end
    f.actions
  end

end
