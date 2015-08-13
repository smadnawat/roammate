ActiveAdmin.register Event do
  menu priority: 7
  permit_params :event_name, :place, :event_time,:image,:link, :city, :event_date,:host_name

  index download_links: [:csv] do
    selectable_column
    # id_column
    column :event_name
    column :host_name
    column :place
    column "Image" do |resources|
      image_tag resources.image_url(:thumbnail)
    end
    column "Time"  do |resources|
      resources.event_time
    end
    column "Date" do |resources|
      resources.event_date.to_date if resources.event_date.present?
    end
    column "link" do |resources|
      body link_to resources.link,"#{resources.link}",:target => "_blank"
    end
    column :city
    actions name: "Actions"
  end

  filter :city_cont, label: 'Search by city'
  filter :event_name_cont, label: 'Search by name'
  # filter :sign_in_count
  # filter :created_at

  show :title => :event_name do
    attributes_table do
      row :event_name
      row :host_name
      row "Image" do |resources|
        image_tag resources.image_url(:thumbnail)
      end
      row :place
      row :event_time
      row :event_date
      row :link
      row :city
    end
   
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Admin Details" do
      f.input :event_name
      label :Please_enter_event_name,:class => "label_error" ,:id => "event_name_label"
      f.input :host_name
      label :Please_enter_host_name,:class => "label_error" ,:id => "host_name_label"
      f.input :image,:as => :file
      f.input :place
      label :Please_enter_place,:class => "label_error" ,:id => "place_label"
      f.input :event_time ,:class =>"time_holder"
      label :Please_enter_event_time,:class => "label_error" ,:id => "event_time_label"
      f.input :event_date, as: :datepicker, datepicker_options: { min_date: Date.today}
      label :Please_enter_event_date,:class => "label_error" ,:id => "event_date_label"
      f.input :link
      label :Please_enter_link,:class => "label_error" ,:id => "link_label"
      f.input :city
      label :Please_enter_city,:class => "label_error" ,:id => "city_label"
    end
    f.actions
  end

end
