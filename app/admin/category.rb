ActiveAdmin.register Category do
  menu priority: 10
  permit_params :category_name

  index do
    selectable_column
    column "Name" do |resources|
      resources.category_name
    end
    actions name: "Actions"
  end

  filter :category_name_cont, label: 'Search by name'

  form do |f|
    f.inputs "Admin Details" do
      f.input :category_name
    end
    f.actions
  end

  show do
    attributes_table do
      row :category_name
      row :created_at
    end
  end

end
