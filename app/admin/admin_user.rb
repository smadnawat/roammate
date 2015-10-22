ActiveAdmin.register AdminUser do
  # menu false
  menu priority: 0
  permit_params :email, :password, :password_confirmation, :is_admin
  actions :all, :except => [:destroy]
  config.filters = false

  index download_links: [:csv] do
    selectable_column
    # id_column
    column :email
    column "Admin Type" do |resource|
      status_tag (resource.is_admin ? "Admin" : "Event Admin"), (resource.is_admin ? :ok : :error) 
    end
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
      f.input :is_admin, :label => 'Admin Type', :as => :select, :collection => {'Admin' => true,'Event Admin' => false},include_blank: false, allow_blank: false
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

    controller do
      def index
        if current_admin_user.is_admin 
         super
        else
         redirect_to :back ,:alert => "You are not allowed to access this Page!"
        end
      end
    end


end
