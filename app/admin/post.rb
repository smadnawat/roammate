ActiveAdmin.register Post do
  menu priority: 8
  permit_params :title, :content, :image, :user_id,:user_type,:admin_user_id
  actions :all
  index download_links: [:csv] do
    selectable_column
    column "User name" do |resources|
      if resources.user_id.present?
          resources.user.profile.first_name
        else
          "Team Roammate"
        end
    end
    column "User type" do |resources|
      resources.user_type
    end
    column "Post" do |resources|
      resources.content
    end
    column "City" do |resources|
      if resources.user_id.present?
          resources.user.current_city
      else
          "Roammate location"
      end
    end
    column "Date" do |resources|
      resources.created_at.to_date
    end
    actions name: "Actions"
  end

  filter :user_profile_first_name_cont, label: 'Search by User Name'

  show :title => :title do
    attributes_table do
      row :title
      row :content
      row "Image" do |resources|
        image_tag resources.image_url(:display)
      end
      row "User" do |resources|
        if resources.user_id.present?
          resources.user.profile.first_name
        else
          "Admin user"
        end
      end
      row "User type" do |resources|
        resources.user_type
      end
      row "Comments" do |resources|
        if resources.comments.present?
          resources.comments.each do |cm|
             b "#{cm.user.profile.first_name } :" 
             body "#{cm.reply}" 
             body link_to 'X',delete_comment_path(resources.id,cm.id)     
             br    
          end
        else
          "Not any comment"
        end
      end
    end
  end


  form do |f|
    f.inputs "Admin Details" do
      f.input :title
      label :Please_enter_title,:class => "label_error" ,:id => "title_label"
      f.input :content
      label :Please_enter_content,:class => "label_error" ,:id => "content_label"
      f.input :image,:as => :file
      if params[:action] != "edit"
        f.input :admin_user_id,:input_html => {:value => current_admin_user.id,:readonly=>true }
        f.input :user_type,:input_html => {:value => "Roammate",:readonly=>true } 
      end
    end
    f.actions
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
