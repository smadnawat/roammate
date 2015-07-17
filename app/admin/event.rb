ActiveAdmin.register Event do
  menu priority: 7
  permit_params :event_name, :place, :event_time, :link, :city, :event_date

  index do
    selectable_column
    # id_column
    column :event_name
    column :place
    column "Time"  do |resources|
      resources.event_time
    end
    column "Date" do |resources|
      resources.event_date
    end
    column :link
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
      row :place
      row :event_time
      row :event_date
      row :link
      row :city
    end
  end

  # form :html => { :enctype => "multipart/form-data" } do |f|  
  #   f.inputs "PromoCodes" do
  #   f.input :promo_code
  #   f.input :start_date, :as => :datepicker
  #   f.input :start_time
  # end
  # f.buttons



  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Admin Details" do
      f.input :event_name
      label :Please_enter_event_name,:class => "label_error" ,:id => "event_name_label"
      label :Please_enter_valid_time_format,:class => "label_error" ,:id => "event_name_label2"
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
