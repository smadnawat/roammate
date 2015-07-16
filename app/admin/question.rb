ActiveAdmin.register Question , :as => "Messages" do
  menu priority: 4
  permit_params :question, :interest_id, :category_id

  index do
    selectable_column
    # id_column
    column "Message" do |resources|
      resources.question
    end
    column "Category" do |resources|
      resources.category.category_name
    end
    actions name: "Actions"
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

  show do
    attributes_table do
      row :question
      row "Interest" do |resources|
        resources.interest.interest_name
      end
      row "category" do |resources|
        resources.category.category_name
      end
    end
  end

end
