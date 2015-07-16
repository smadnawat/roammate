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
    column "Image" do |resources|
      image_tag resources.image_url(:thumbnail)
    end

    column "Icon" do |resources|
      image_tag resources.icon_url(:thumbnail)
    end

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
      label :Please_enter_interest_name,:class => "label_error" ,:id => "interest_name_label"
      f.input :image
      f.input :icon
      f.input :description
      label :Please_enter_description,:class => "label_error" ,:id => "description_label"
      f.input :category_id, :label => 'Category name', :as => :select, :collection => Category.all.map{|u| ["#{u.category_name}", u.id]},include_blank: false, allow_blank: false
    end
    f.actions
  end

  show do
    attributes_table do
      row :interest_name
      row :description
      row "Image" do |resources|
        image_tag resources.image_url(:display)
      end
      row "Icon" do |resources|
        image_tag resources.icon_url(:display)
      end
      row "Category" do |resources|
        resources.category.category_name
      end
      row :created_at
    end
  end

end
