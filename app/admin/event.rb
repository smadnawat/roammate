ActiveAdmin.register Event do
  menu priority: 7
  permit_params :event_name, :place, :event_time, :link, :city

  index do
    selectable_column
    # id_column
    column :event_name
    column :place
    column "Time" do |resources|
      resources.event_time
    end
    column :link
    column :city
    actions name: "Actions"
  end

  filter :city_cont, label: 'Search by city'
  filter :event_name_cont, label: 'Search by name'
  # filter :sign_in_count
  # filter :created_at

  show do
    attributes_table do
      row :event_name
      row :place
      row :event_time
      row :link
      row :city
    end
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :event_name
      f.input :place
      f.input :event_time
      f.input :link
      f.input :city
    end
    f.actions
  end

end
