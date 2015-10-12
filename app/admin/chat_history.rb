ActiveAdmin.register_page "Chat history" do
  menu priority: 5
  
  content do
      rating = Rating.where("rate = ?","-1")
    table :class => "index_table index" do
      tr do
        th { 'Reciever(user1)' }
        th { 'Email' }
        th { 'Rate' }
        th { 'Rating by(user2)' }
        th { 'Reason'}
        th { 'Created at'}
        th { 'Action' }
      end 
      if rating.present?
        rating.each do |rate| 
          tr do
            td { rate.user.profile.first_name }
            td { rate.user.profile.fb_email }
            td { rate.rate }
            td { User.find(rate.rater_id).profile.first_name }
            td { rate.reason.present? ? rate.reason : "Not provided"}
            td { rate.created_at.to_date}
            td :class=>"" do 
              a  link_to 'View', admin_chat_path(user1: rate.user.id ,user2: rate.rater_id) 
              a " "
              a  link_to "Delete",delete_bad_rateing_path(rate),method: :delete ,:data => { :confirm => "Are you sure, you want to delete this rating?" }
            end
          end
        end
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
