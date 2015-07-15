ActiveAdmin.register Interest do
  menu priority: 2
  permit_params :interest_name, :image, :icon, :description, :status, :category_id

  # permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    # id_column
    column "Name" do |resources|
      resources.interest_name
    end
    column :image
    column :icon
    column :description
    column "Catagory" do |resources|
      resources.category.category_name
    end
    actions name: "Actions"
  end

  filter :interest_name_cont, label: 'Search by name'

  form do |f|
    f.inputs "Admin Details" do
      f.input :interest_name
      f.input :image
      f.input :icon
      f.input :description
      f.input :category_id, :label => 'Category name', :as => :select, :collection => Category.all.map{|u| ["#{u.category_name}", u.id]},include_blank: false, allow_blank: false
    end
    f.actions
  end

  show do
    attributes_table do
      row :interest_name
      row :description
      row :image
      row :icon
      row "Category" do |resources|
        resources.category.category_name
      end
      row :created_at
    end
  end

end
