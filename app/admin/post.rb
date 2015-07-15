ActiveAdmin.register Post do
  menu priority: 8
  permit_params :title, :content, :image, :user_id
  actions :all, :except => [:new]
  index do
    selectable_column
    column "User Name" do |resources|
      resources.user.profile.first_name + " " + resources.user.profile.last_name 
    end
    column "Post" do |resources|
      resources.title
    end
    column "City" do |resources|
      resources.user.cities.first
    end
    column "Date" do |resources|
      resources.created_at.to_date
    end
    actions name: "Actions"
  end

  filter :created_at_cont, :as => :date_picker, label: 'Search by Date'

  show do
    attributes_table do
      row :title
      row :content
      row :image
      row :user_id
    end
  end

  # filter :sign_in_count
  # filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :title
      f.input :content
      f.input :image
      f.input :user_id, :as => :select, :collection => User.all.map{|u| ["#{u.profile.first_name} #{u.profile.last_name}", u.id]}
    end
    f.actions
  end

end
