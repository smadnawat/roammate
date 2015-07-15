ActiveAdmin.register Profile do
  menu priority: 1
  permit_params :email, :first_name, :last_name, :image, :location, :gender, :status, :locale, :timezone
  actions :all, :except => [:new, :show]
  index do
    selectable_column
    # id_column
    column "Name" do |resource|
      resource.first_name + " " + resource.last_name
    end
    column :email
    column "Age" do |resource|
      Date.today 
    end
    column :image
    column "Point and Ratings" do |resource|
      resource.user.ratings.first.rate
    end
    column "City" do |resources|
      resources.location
    end
     actions name: "Actions"
  end

  filter :email_cont, label: 'Search by email'

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :image
      f.input :location
      f.input :gender, :as => :select,collection: [["male","male"],["female","female"]],include_blank: false, allow_blank: false
      f.input :locale
      f.input :timezone
    end 
    f.actions
  end

  show do
    attributes_table do
      row :interest_name
      row :description
      row :image
      row :icon
      row :status
      row :catagory
     end
  end

end

