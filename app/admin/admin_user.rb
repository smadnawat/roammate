ActiveAdmin.register AdminUser do
  menu false
  permit_params :email, :password, :password_confirmation
  actions :all, :except => [:new, :destroy]
  config.filters = false

  index download_links: [:csv] do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table do
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row "Admin Account Since" do |resources|
        resources.created_at
      end
      row "Last Profile Updated At" do |resources|
        resources.updated_at
      end
    end
  end


end
