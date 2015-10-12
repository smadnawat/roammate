ActiveAdmin.register Question , :as => "Messages" do
  menu priority: 4
  permit_params :question, :interest_id, :category_id

  index download_links: [:csv] do
    selectable_column
    # id_column
    column "Message" do |resources|
      resources.question
    end
    column "Category" do |resources|
      resources.category.category_name
    end
    column "Status" do |resource|
      status_tag (resource.status ? "Active" : "Deactive"), (resource.status ? :ok : :error) 
    end
        column "Actions" do |resource|
        links = ''.html_safe
        a do
          if resource.status?
            links += link_to 'Deactive', message_status_path(resource),:data => { :confirm => 'Are you sure, you want to deactive this profile?' }
          else
           links += link_to 'Active', message_status_path(resource),:data => { :confirm => 'Are you sure, you want to active this profile?' }
           end
            links += " / "
            links +=  link_to 'Edit', edit_admin_message_path(resource)
            links += " / "  
            links += link_to 'Delete', edit_admin_message_path(resource), method: :delete,:data => { :confirm => 'Are you sure, you want to delete this profile?' }
            links += " / "
            links += link_to 'View', admin_message_path(resource)

       end
       links
     end
  end

  filter :category_category_name_cont, :as => :string , :label => "Search By Category"

  form do |f|
    f.inputs "Admin Details" do
      f.input :question
      label :Please_enter_email,:class => "label_error" ,:id => "question_label"
      f.input :interest_id, :as => :select, :collection => Interest.all.map{|u| ["#{u.interest_name}", u.id]},include_blank: false, allow_blank: false
      f.input :category_id, :as => :select, :collection => Category.all.map{|u| ["#{u.category_name}", u.id]},include_blank: false, allow_blank: false
    end
    f.actions
  end

  show :title => "Question" do
    attributes_table do
      row :question
      row "Status" do |resources|
         status_tag (resource.status ? "Active" : "Deactive"), (resource.status ? :ok : :error)
      end
      row "Interest" do |resources|
        resources.interest.interest_name
      end
      row "category" do |resources|
        resources.category.category_name
      end
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
