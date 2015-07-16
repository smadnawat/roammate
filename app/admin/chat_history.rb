ActiveAdmin.register_page "Chat history" do
  menu priority: 5
  #config.filters = false
  #actions :all, :except => [:new, :edit]
  # permit_params :email, :password, :password_confirmation

  
  content do
      rating = Rating.where("rate = ? ","-1")
    table :class => "index_table index" do
      tr do
        th { 'Reciever(user1)' }
        th { 'Email' }
        th { 'Rate' }
        th { 'Rating by(user2)' }
        th { 'Action' }
      end 
      rating.each do |rate| 
        tr do
          td { rate.user.profile.first_name }
          td { rate.user.profile.email }
          td { rate.rate }
          td { User.find_by_id(rate.rater_id).profile.first_name }
           td :class=>"" do 
                a  link_to 'View', admin_chat_path(user1: rate.user.id ,user2: rate.rater_id) 
                a " "
                a " "
                a  link_to "Delete",delete_bad_rateing_path(rate),method: :delete ,:data => { :confirm => "Are you sure, you want to delete this rating?" }
             end
        end
      end
    end 

  end

end
