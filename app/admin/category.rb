ActiveAdmin.register Category do
  menu priority: 10
  permit_params :category_name

  index download_links: [:csv] do
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
      label :Please_enter_category_name,:class => "label_error" ,:id => "category_name_label"
    end
    f.actions
  end

  show :title => :category_name do
    attributes_table do
      row :category_name
      row :created_at
    end
  end

  controller do
      def index
        if current_admin_user.is_admin #|| Group.set_access_for_current_admin(current_admin_user).include?("Banner list")
         p "++00000000000++++++++#{current_admin_user.is_admin}+++++++++++++"
         super
        else
         redirect_to :back ,:alert => "You are not allowed to access this Page!"
        end
      end
    end

end
