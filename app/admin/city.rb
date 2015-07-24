ActiveAdmin.register City do
  menu priority: 9
  actions :all, :except => [:new, :edit, :destroy]
  # permit_params :email, :password, :password_confirmation

  index download_links: [:csv] do
    selectable_column
    column :city_name
    column :state
    column :country
    actions name: "Actions"
  end

  filter :city_name_cont, label: 'search by city name'

  show :title => :city_name do

    attributes_table do
      row :city_name
      row :state
      row :country
    end
  end


end
