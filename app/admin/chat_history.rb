ActiveAdmin.register Message, as: "chat_history" do
  menu priority: 5
  config.filters = false
  actions :all, :except => [:new, :edit]
  # permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    # id_column
    column "Sender(User1)" do |resources|
      resources.user.profile.email
    end

    column "Reciever(User2)" do |resources|
      User.find_by_id(resources.reciever).profile.email
    end 

    column "Rating by user" do |resources|
      # Rating.find_by_id(resources.
    end

    column "Rating" do |resources|
      # Rating.find_by_user_id_and_rater_id(resources.user_id, resources.reciever).rate
    end

    # column :created_at
    actions name: "Actions"
  end

  # show do
  #   attributes_table do
  #     row :content
  #     row :user_id

  #     row "Email" do |resources|
  #       resources.user.profile.email
  #     end
      
  #     row :created_at
  #   end
  # end


end
