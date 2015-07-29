ActiveAdmin.register ServicePoint do
	menu priority: 11
  actions :all, :except => [:new, :destroy]
   permit_params :point

  index download_links: [:csv] do
    selectable_column
    # id_column
    column "Service Name" do |resources|
      resources.service
    end
    column :point
    column :created_at
    actions name: "Actions"
  end

  filter :service_cont, :as => :string , :label => "Search By Service"
 
  show :title => "Service And Point" do
    attributes_table do
      row :service
      row :point
      row :created_at
    end
  end

    form do |f|
	    f.inputs "Service And Point" do
	      f.input :service,:input_html => {:readonly=>true } 
	      f.input :point
        label :Please_enter_points,:class => "label_error" ,:id => "service_point_label"
	    end
    f.actions
  end
end